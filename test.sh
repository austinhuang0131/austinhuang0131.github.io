#!/bin/bash

IFS=$'\n'
Lines=$(cat _includes/matrix_base.md)

echo "| **Homeserver name** | **Operating structure** | **Jurisdiction (and Server location)** | **Rules?** | **Privacy Policy?** | **Privacy concerns?** | **Note** | **Registration method** | **Version** |" > _includes/matrix_prod.md
echo "| --- | --- | --- | --- | --- | --- | --- | --- | --- |" >> _includes/matrix_prod.md

for Line in $Lines
do
    if [[ $Line =~ \[([0-9a-z]+\.[0-9a-z]+)\] ]]; then
        raw="${BASH_REMATCH[1]}"
        base=$(curl -L "https://$raw/.well-known/matrix/server" | jq '."m.server"' | sed s/\"//g)
        if [[ -z "$base" ]] || [ "$base" == "null" ]; then
            DNS=$(curl "https://dns.google/resolve?name=_matrix._tcp.$raw&type=SRV" | jq '.Answer[0].data' | sed -E 's/(^"|"$|([0-9]+ ){2})//g')
            SRV_PORT=$(echo "$DNS" | grep -oE "^\d+")
            SRV_DOMAIN=$(echo "$DNS" | grep -oE "([a-z0-9]+\.)+$" | sed 's/\.$//')
            if [[ -n "$SRV_PORT" ]] && [[ -n "$SRV_DOMAIN" ]]; then
                body=$(curl -L "https://$SRV_DOMAIN:$SRV_PORT/_matrix/federation/v1/version")
            else
                body=$(curl -L "https://$raw/_matrix/federation/v1/version")
            fi
        else
            body=$(curl -L "https://$base/_matrix/federation/v1/version")
        fi
        name=$(echo $body | jq .server.name | sed s/\"//g)
        version=$(echo $body | jq .server.version | sed s/\"//g)
        if [[ "$name" == "Synapse" ]] && [[ -n "$version" ]]; then
            echo "$Line $version |" >> _includes/matrix_prod.md
        elif [[ -n "$name" ]] && [[ -n "$version" ]]; then
            echo "$Line $name $version |" >> _includes/matrix_prod.md
        else
            echo "$Line Error!! |" >> _includes/matrix_prod.md
        fi
    fi
done
