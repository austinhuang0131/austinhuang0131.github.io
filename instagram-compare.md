---
title: I'd like to compare my Instagram followers/followings list!
comments: true
description: Weed out the fakes! Here's one simple trick to effectively compare your followers and followings list, so you can unfollow those traitors who never follows you back, and keep your Instagram COOL and CLEAN, without leaking your password!
permalink: /instagram-compare
---

Last tested **May 30th, 2020**.

**READ ME FIRST:** This script attempts to mimic Instagram web interface behaviour as much as possible (As it fetches the same URL when you scroll down the follower/ing list yourself), and I do not think occasional use (i.e. Do not use this script excessively!) of the script will trigger them. However, I cannot guarantee that Instagram will not take actions for this. While I poured my best effort in writing the script, it remains your sole responsibility to secure your account and I am not liable for any damages caused.

1. [Log into Instagram](https://instagram.com) **on a computer Chrome.**
2. Click the three dots on the right hand side of the browser address bar, then "More Tools" > "Developer Tools". Alternatively, right click anywhere on the page, then "Inspect".
3. Navigate to the "Console" tab of the right sidebar.
4. Paste the following code next to the `>` sign and press <kbd>ENTER</kbd>:
  ```js
const random_wait_time=(a=400)=>new Promise(b=>{setTimeout(()=>b(),Math.random()*a+100)}),ratelimit=()=>new Promise(a=>{setTimeout(()=>a(),6e4)}),getList=async(a,b)=>{let c="follower"===a||"following"!==a&&"0";if("0"===c)throw"first argument must be \"follower\" or \"following\".";let d=[],e=document.cookie.split("ds_user_id=")[1].split("; ")[0],f=c?"c76146de99bb02f6415203be841dd25a":"d04b0a864b4b54837c0d870b0e77e076",g=c?"true":"false",h=c?"edge_followed_by":"edge_follow",i=!0,j=`https://www.instagram.com/graphql/query/?query_hash=${f}&variables={"id":"${e}","include_reel":true,"fetch_mutual":${g},"first":12}`;for(;i;){const a=await fetch(j).then(a=>a.json()).then(a=>{const b=[];for(const c of a.data.user[h].edges)b.push(c.node.username);return{edges:b,endCursor:a.data.user[h].page_info.end_cursor}}).catch(async()=>"undefined"===j.split(`,"after":`)[1].split(`"}"`)[0]||"null"===j.split(`,"after":`)[1].split(`"}"`)[0]?{edges:[]}:(console.log("Seems like I hit a 429, will wait 60 seconds (The process is still running, don't close the tab!)"),await ratelimit(),{edges:[],endCursor:j.split(`,"after":"`)[1].split(`"}`)[0]}));await random_wait_time(),d=[...d,...a.edges],null===a.endCursor&&(i=!1),j=`https://www.instagram.com/graphql/query/?query_hash=${f}&variables={"id":"${e}","include_reel":true,"fetch_mutual":${g},"first":12,"after":"${a.endCursor}"}`}return b||console.log(`========= ${a.toUpperCase()} =========\n`+d.join("\n")),d},findDiff=async()=>{const d=await getList("follower",!0),a=await getList("following",!0),b=a.filter(a=>-1===d.indexOf(a));return console.log(`========= Following, not followed =========\n`+b.join("\n")),b};
  ```
5. Now we have all the functions defined, you can do one of the following 3 things by entering the respective function next to the `>` again. Wait a while (more followers = more time to run), then you'll get a nicely-formatted result.

* To see followers: `getList("follower")`
* To see following: `getList("following")`
* To see people you're following but are not following you: `findDiff()`

That pretty much does the trick. This will take a while (The more users it needs to process, the more time it'll take). Hope you enjoyed. If you think this is helpful, [donate to me!](./donate)

## Credits
The getList function is an adaption of [this StackOverflow answer](https://stackoverflow.com/a/57443299) by [Valentink](https://stackoverflow.com/users/11899009/valentink). Licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

On the top, the sentence "Weed out the fakes!" was written by [@sophucking_done](https://instagram.com/sophucking_done).

This page, like this entire website, is [open source](https://github.com/austinhuang0131/austinhuang0131.github.io/blob/master/instagram-compare.md). All the credits are legit: I don't sponsor them, nor do they sponsor me.

## Wait, what if I only have a phone?
Android users: Use [InstaGrabber](https://gitlab.com/AwaisKing/instagrabber). (Not affiliated)

1. Get the app (This app does not entirely substitute the actual Instagram app, unfortunately).
2. Log in (according to README).
3. Click either "Following" or "Follower", doesn't matter.
4. Wait till the list fully loads. Otherwise, the app will crash! Be patient.
5. Press the eye button on the top-right. You'll see your follower-following list being split into 3 categories.
6. The app can't follow/unfollow, so you can click on profile, "Open in Instagram", and follow/unfollow.

## Wait, does this steal my password?
No. This code snippet only pings 1 website, and that is Instagram's own GraphQL API. The only cookie read by the script is your user ID (`ds_user_id`). Nothing else is provided to the script. Here's the annotated un-minified version:

```js
// mathematically generate a wait time between 0.1 and 0.5 seconds, to prevent ratelimiting
const random_wait_time = (waitTime = 400) => new Promise((resolve, reject) => {
    setTimeout(() => {
        return resolve();
    }, (Math.random() * waitTime + 100));
});

const ratelimit = () => new Promise((resolve, reject) => {
    setTimeout(() => {
        return resolve();
    }, 60000);
});

// get follower/following list.
// the first argument is type of list to fetch, either "follower" or "following".
// the second argument is whether to NOT log the results, which is for the latter findDiff function, default "false". normal users shouldn't set this to "true"
const getList = async (follower, nolog) => {
    let type = (follower === "follower") ? true : ((follower === "following") ? false : "0"); // convert first one to true/false for convenience
    if (type === "0") throw "first argument must be \"follower\" or \"following\"."; // catch typos
    let userFollowers = [], // set up list of followers
        batchCount = 12, // fetch 12 in 1 request, same as the web interface
        userId = document.cookie.split("ds_user_id=")[1].split("; ")[0], // find your user id
        hash = type ? "c76146de99bb02f6415203be841dd25a" : "d04b0a864b4b54837c0d870b0e77e076", // hash, apparently these two are constant values, but instagram might change them
        mutual = type ? "true" : "false", // followers or following?
        variable = type ? "edge_followed_by" : "edge_follow", // followers or following? part 2
        running = true, // is it fetching users?
    url = `https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":${batchCount}}`; // set up the url
    while (running) { // if there's users left to fetch
        const followersResponse = await fetch(url) // ping url
            .then(res => res.json()) // parse json body
            .then(res => {
                const nodeIds = [];
                for (const node of res.data.user[variable].edges) {
                    nodeIds.push(node.node.username); // for each user object, find username and put them in the list
                }
                return {
                    edges: nodeIds, // list of users
                    endCursor: res.data.user[variable].page_info.end_cursor // instagram doesn't allow fetching a lot of users at once, so it needs to know where to start the next fetching
                };
            }).catch(async err => { // if this broke, show error
                if (url.split(`,"after":`)[1].split(`"}"`)[0] === "undefined" || url.split(`,"after":`)[1].split(`"}"`)[0] === "null") {
                  return {
                    edges: []
                  }
                }
                else {
                  console.log("Seems like I hit a 429, will wait 60 seconds (The process is still running, don't close the tab!)");
                  await ratelimit();
                  return {
                      edges: [],
                      endCursor: url.split(`,"after":"`)[1].split(`"}`)[0]
                  };
                }
            });
        await random_wait_time(); // wait
        userFollowers = [...userFollowers, ...followersResponse.edges]; // append the newly-acquired list to the old list
        if (followersResponse.endCursor === null) running = false; // if no more users, stop fetching them
        url = `https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":${batchCount},"after":"${followersResponse.endCursor}"}`; // remake url
    }
    if (!nolog) console.log(`========= ${follower.toUpperCase()} =========\n` + userFollowers.join("\n")); // show
    return userFollowers;
};

const findDiff = async () => {
    const a = await getList("follower", true),
        b = await getList("following", true),
        c = b.filter(u => a.indexOf(u) === -1); // for each followings, if not follower, then push to list
    console.log(`========= Following, not followed =========\n` + c.join("\n")) // show
    return c;
}
```

## Wait, I thought this page featured a different method?
Prior to the change, this page featured a method that reads elements on the webpage. However,

* It has too many steps
* Instagram layout seems to be different for everyone and the method cannot work reliably

So, I found this backend method and I'd now recommend this method over the previous one.

{% include def.html %}
