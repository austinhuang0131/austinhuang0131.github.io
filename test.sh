#!/bin/bash

IFS=$'\n'
Lines=$(cat _includes/matrix_base.md)

echo "| **Homeserver name** | **Operating structure** | **Jurisdiction (and Server location)** | **Rules?** | **Privacy Policy?** | **Privacy concerns?** | **Note** | **Registration method** | **Version** |" > _includes/matrix_prod.md

for Line in $Lines
do
    if [[ $Line =~ \[([0-9a-z]+\.[0-9a-z]+)\] ]]
    then
        raw="${BASH_REMATCH[1]}"
        base=$(curl "https://$raw/.well-known/matrix/server" | jq '."m.server"' | sed s/\"//g)
        if [ -n base ] && [ base != "null" ]; then
            body=$(curl "https://$base/_matrix/federation/v1/version")
            if [[ -n base ]]; then
                name=$(echo $body | jq .server.name | sed s/\"//g)
                version=$(echo $body | jq .server.version | sed s/\"//g)
                echo "$Line $name $version |" >> _includes/matrix_prod.md
            else echo "$Line Matrix error!! |" >> _includes/matrix_prod.md
        fi
        else echo "$Line Domain error!! |" >> _includes/matrix_prod.md
        fi
    fi
done

