---
title: I'd like to compare my Instagram followers/followings list!
comments: true
description: Weed out the fakes! Here's one simple trick to effectively compare your followers and followings list, so you can unfollow those traitors who never follows you back, and keep your Instagram COOL and CLEAN, without leaking your password!
permalink: /instagram-compare
---

Last tested **May 8th, 2020**.

1. [Log into Instagram](https://instagram.com) **on a computer.**
2. Go to your profile.
3. Click the three dots on the top-right, then "More Tools" > "Developer Tools".
4. Navigate to the "Console" tab of the right sidebar.
5. Paste the following code next to the `>` sign and press <kbd>ENTER</kbd>: (See credits below.)
  ```js
  const random_wait_time = (waitTime = 300) => new Promise((resolve, reject) => {
    setTimeout(() => {
      return resolve();
    }, Math.random() * waitTime);
  });

  function readCookie(name) {
      var nameEQ = name + "=";
      var ca = document.cookie.split(';');
      for(var i=0;i < ca.length;i++) {
          var c = ca[i];
          while (c.charAt(0)==' ') c = c.substring(1,c.length);
          if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
      }
      return null;
  }

  const getList = async(follower, nolog) => {
    let type = (follower === "follower") ? true : ((follower === "following") ? false : "0");
    if (type === "0") throw "first argument must be \"follower\" or \"following\".";
    let userFollowers = [],
      userFollowerCount = type ? document.querySelectorAll('a[href$="followers/"] > span')[0].textContent
   : document.querySelectorAll('a[href$="following/"] > span')[0].textContent
      batchCount = 20,
      actuallyFetched = 20,
      userId = readCookie("ds_user_id"),
      hash = type ? "c76146de99bb02f6415203be841dd25a" : "d04b0a864b4b54837c0d870b0e77e076",
      mutual = type ? "true" : "false",
      variable = type ? "edge_followed_by" : "edge_follow"
      url = `https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":"${batchCount}"}`;
    while (userFollowerCount > 0) {
      const followersResponse = await fetch(url)
        .then(res => res.json())
        .then(res => {
          const nodeIds = [];
          for (const node of res.data.user[variable].edges) {
            nodeIds.push(node.node.username);
          }
          actuallyFetched = nodeIds.length;
          return {
            edges: nodeIds,
            endCursor: res.data.user[variable].page_info.end_cursor
          };
        }).catch(err => {
          userFollowerCount = -1;
          return {
            edges: []
          };
        });
      await random_wait_time();
      userFollowers = [...userFollowers, ...followersResponse.edges];
      userFollowerCount -= actuallyFetched;
      url = `https://www.instagram.com/graphql/query/?query_hash=${hash}&variables={"id":"${userId}","include_reel":true,"fetch_mutual":${mutual},"first":${batchCount},"after":"${followersResponse.endCursor}"}`;
    }
    if (!nolog) console.log(`========= ${follower.toUpperCase()} =========\n` + userFollowers.join("\n"));
    return userFollowers;
  };

  const findDiff = async() => {
    const a = await getList("follower", true),
      b = await getList("following", true),
      c = b.filter(u => a.indexOf(u) === -1);
    console.log(`========= Following, not followed =========\n` + c.join("\n"))
    return c;
  }
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
