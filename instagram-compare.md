---
title: I'd like to compare my Instagram followers/followings list!
comments: true
description: (NEW METHOD!) Weed out the fakes! Here's one simple trick to effectively compare your followers and followings list, so you can unfollow those traitors who never follows you back, and keep your Instagram COOL and CLEAN, without leaking your password!
permalink: /instagram-compare
---

Last tested **May 8th, 2020**.

1. [Log into Instagram](https://instagram.com) **on a computer Chrome.**
2. Go to your profile page.
3. Click the three dots on the right hand side of the browser address bar, then "More Tools" > "Developer Tools". Alternatively, right click anywhere on the page, then "Inspect".
4. Navigate to the "Console" tab of the right sidebar.
5. Paste the following code next to the `>` sign and press <kbd>ENTER</kbd>:
  ```js
  const random_wait_time=(e=300)=>new Promise((t,r)=>{setTimeout(()=>t(),Math.random()*e)});function readCookie(e){for(var t=e+"=",r=document.cookie.split(";"),o=0;o<r.length;o++){for(var a=r[o];" "==a.charAt(0);)a=a.substring(1,a.length);if(0==a.indexOf(t))return a.substring(t.length,a.length)}return null}const getList=async(e,t)=>{let r="follower"===e||"following"!==e&&"0";if("0"===r)throw'first argument must be "follower" or "following".';let o=[],a=r?document.querySelectorAll('a[href$="followers/"] > span')[0].textContent:document.querySelectorAll('a[href$="following/"] > span')[0].textContent;for(batchCount=20,actuallyFetched=20,userId=document.cookie.split("ds_user_id=")[1].split("; ")[0],hash=r?"c76146de99bb02f6415203be841dd25a":"d04b0a864b4b54837c0d870b0e77e076",mutual=r?"true":"false",variable=r?"edge_followed_by":"edge_follow",url=`https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":"${batchCount}"}`;a>0;){const e=await fetch(url).then(e=>e.json()).then(e=>{const t=[];for(const r of e.data.user[variable].edges)t.push(r.node.username);return actuallyFetched=t.length,{edges:t,endCursor:e.data.user[variable].page_info.end_cursor}}).catch(e=>(a=-1,{edges:[]}));await random_wait_time(),o=[...o,...e.edges],a-=actuallyFetched,url=`https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":${batchCount},"after":"${e.endCursor}"}`}return t||console.log(`========= ${e.toUpperCase()} =========\n`+o.join("\n")),o},findDiff=async()=>{const e=await getList("follower",!0),t=(await getList("following",!0)).filter(t=>-1===e.indexOf(t));return console.log("========= Following, not followed =========\n"+t.join("\n")),t};
  ```
6. Now we have all the functions defined, you can do one of the following 3 things by entering the respective function next to the `>` again. Wait a while (more followers = more time to run), then you'll get a nicely-formatted result.

* To see followers: `getList("follower")`
* To see following: `getList("following")`
* To see people you're following but are not following you: `findDiff()`

That pretty much does the trick. This will take a while (The more users it needs to process, the more time it'll take). Hope you enjoyed.

## Credits
The getList function is an adaption of [this StackOverflow answer](https://stackoverflow.com/a/57443299) by [Valentink](https://stackoverflow.com/users/11899009/valentink). Licensed under CC BY-SA 4.0.

On the top, the sentence "Weed out the fakes!" was written by [@sophucking_done](https://instagram.com/sophucking_done).

This page, like this entire website, is [open source](https://github.com/austinhuang0131/austinhuang0131.github.io/blob/master/instagram-compare.md).

## Wait, does this steal my password?
This code snippet only pings 1 website, and that is Instagram's own GraphQL API.

The only cookie read by the script is your user ID (`ds_user_id`). The only element read by the script is your current following/follower count (it'll grab from the webpage instead). Nothing else is provided to the script.

Here's the annotated un-minified version:

```js
// mathematically generate a wait time between 0 and 0.3 seconds, to prevent ratelimiting
const random_wait_time = (waitTime = 300) => new Promise((resolve, reject) => {
    setTimeout(() => {
        return resolve();
    }, Math.random() * waitTime);
});

// get follower/following list.
// the first argument is type of list to fetch, either "follower" or "following".
// the second argument is whether to NOT log the results, which is for the latter findDiff function, default "false". normal users shouldn't set this to "true"
const getList = async (follower, nolog) => {
    let type = (follower === "follower") ? true : ((follower === "following") ? false : "0"); // convert first one to true/false for convenience
    if (type === "0") throw "first argument must be \"follower\" or \"following\"."; // catch typos
    let userFollowers = [], // set up list of followers
        userFollowerCount = type ? document.querySelectorAll('a[href$="followers/"] > span')[0].textContent :
        document.querySelectorAll('a[href$="following/"] > span')[0].textContent // how many follower/ings do you have?
        batchCount = 20, // fetch 20 in 1 request
        actuallyFetched = 20, // know how many it actually fetched so it doesn't fetch them again
        userId = document.cookie.split("ds_user_id=")[1].split("; ")[0], // find your user id
        hash = type ? "c76146de99bb02f6415203be841dd25a" : "d04b0a864b4b54837c0d870b0e77e076", // hash, apparently these two are constant values, but instagram might change them
        mutual = type ? "true" : "false", // followers or following?
        variable = type ? "edge_followed_by" : "edge_follow" // followers or following? part 2
    url = `https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":"${batchCount}"}`; // set up the url
    while (userFollowerCount > 0) { // if there's users left to fetch
        const followersResponse = await fetch(url) // ping url
            .then(res => res.json()) // parse json body
            .then(res => {
                const nodeIds = [];
                for (const node of res.data.user[variable].edges) {
                    nodeIds.push(node.node.username); // for each user object, find username and put them in the list
                }
                actuallyFetched = nodeIds.length; // how many did it get?
                return {
                    edges: nodeIds, // list of users
                    endCursor: res.data.user[variable].page_info.end_cursor // instagram doesn't allow fetching a lot of users at once, so it needs to know where to start the next fetching
                };
            }).catch(err => { // if this broke, stop the process and dump an empty list
                userFollowerCount = -1;
                return {
                    edges: []
                };
            });
        await random_wait_time(); // wait
        userFollowers = [...userFollowers, ...followersResponse.edges]; // append the newly-acquired list to the old list
        userFollowerCount -= actuallyFetched; // how many left to fetch?
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

Therefore, no.

## Wait, I thought this page featured a different method?
Prior to the change, this page featured a method that reads elements on the webpage. However,

* It has too many steps
* Instagram layout seems to be different for everyone and the method cannot work reliably

So, I found this backend method and I'd now recommend this method over the previous one.
