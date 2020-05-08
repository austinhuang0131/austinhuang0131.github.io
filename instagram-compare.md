---
title: I'd like to compare my Instagram followers/followings list!
comments: true
description: (NEW METHOD!) Weed out the fakes! Here's one simple trick to effectively compare your followers and followings list, so you can unfollow those traitors who never follows you back, and keep your Instagram COOL and CLEAN, without leaking your password!
permalink: /instagram-compare
---

Last tested **May 8th, 2020**.

1. [Log into Instagram](https://instagram.com) **on a computer.**
2. Go to your profile.
3. Click the three dots on the top-right, then "More Tools" > "Developer Tools".
4. Navigate to the "Console" tab of the right sidebar.
5. Paste the following code next to the `>` sign and press <kbd>ENTER</kbd>: (See credits below.)
  ```js
  const random_wait_time=(e=300)=>new Promise((t,r)=>{setTimeout(()=>t(),Math.random()*e)});function readCookie(e){for(var t=e+"=",r=document.cookie.split(";"),o=0;o<r.length;o++){for(var a=r[o];" "==a.charAt(0);)a=a.substring(1,a.length);if(0==a.indexOf(t))return a.substring(t.length,a.length)}return null}const getList=async(e,t)=>{let r="follower"===e||"following"!==e&&"0";if("0"===r)throw'first argument must be "follower" or "following".';let o=[],a=r?document.querySelectorAll('a[href$="followers/"] > span')[0].textContent:document.querySelectorAll('a[href$="following/"] > span')[0].textContent;for(batchCount=20,actuallyFetched=20,userId=readCookie("ds_user_id"),hash=r?"c76146de99bb02f6415203be841dd25a":"d04b0a864b4b54837c0d870b0e77e076",mutual=r?"true":"false",variable=r?"edge_followed_by":"edge_follow",url=`https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":"${batchCount}"}`;a>0;){const e=await fetch(url).then(e=>e.json()).then(e=>{const t=[];for(const r of e.data.user[variable].edges)t.push(r.node.username);return actuallyFetched=t.length,{edges:t,endCursor:e.data.user[variable].page_info.end_cursor}}).catch(e=>(a=-1,{edges:[]}));await random_wait_time(),o=[...o,...e.edges],a-=actuallyFetched,url=`https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":${batchCount},"after":"${e.endCursor}"}`}return t||console.log(`========= ${e.toUpperCase()} =========\n`+o.join("\n")),o},findDiff=async()=>{const e=await getList("follower",!0),t=(await getList("following",!0)).filter(t=>-1===e.indexOf(t));return console.log("========= Following, not followed =========\n"+t.join("\n")),t};
  ```

6. Now we have all the functions defined, you can do one of the following 3 things by entering the respective function next to the `>` again. Wait a while (more followers = more time to run), then you'll get a nicely-formatted result.

* To see followers: `getList("follower")`
* To see following: `getList("following")`
* To see people you're following but are not following you: `findDiff()`

That pretty much does the trick. Hope you enjoy.

## Credits
The getList function is an adaption of [this StackOverflow answer](https://stackoverflow.com/a/57443299).

The readCookie function is from [this StackOverflow answer](https://stackoverflow.com/a/15724300).

This page is [open source](https://github.com/austinhuang0131/austinhuang0131.github.io/blob/master/instagram-compare.md).

## Wait, does this steal my password?
This code snippet only pings 1 website, and that is Instagram's own GraphQL API.

The only cookie read by the script is your user ID (`ds_user_id`).

Therefore, no.
