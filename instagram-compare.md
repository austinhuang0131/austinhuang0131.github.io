---
title: I'd like to compare my Instagram followers/followings list!
comments: true
description: Weed out the fakes! Here's one simple trick to effectively compare your followers and followings list, so you can unfollow those traitors who never follows you back, and keep your Instagram COOL and CLEAN!
permalink: /instagram-compare
---

~~tbh it requires some knowledge, not just "simple" simple~~

**REQUIRES A COMPUTER WITH CHROME ON IT.** I tested this method on November 7 2018, if it deprecates please [contact me](https://instagram.com/austinhuang.me).

1. [Log into Instagram](https://instagram.com) **on a computer.**
2. [Google "Compare text online".](https://www.google.ca/search?q=compare+text+online) Just use any service, they do the same thing.
3. Go to your profile, then your follower list.
4. Instagram now pushes Recommended users under your follower list. For your first scroll, you MUST scroll to the white space between Recommended users (Which has "<username> and some others also follows" under) and actual followers. Afterwards, scroll to the bottom until the list stops loading.
5. Click the three dots on the top-right, then "More Tools" > "Developer Tools".
6. Navigate to the "Console" tab of the right sidebar.
7. Paste the following code next to the `>` sign and press <kbd>ENTER</kbd>:
  ```js
  [].slice.call(document.getElementsByTagName("ul")[2].getElementsByTagName("li")).map(r => r.children[0].children[0].children[1].children[0].textContent).sort().join("\n")
  ```
  If this doesn't work, another user has suggested to use this code: (Yes, it is reported that some people have different lagouts)
  ```js
  [].slice.call(document.getElementsByTagName("ul")[2].getElementsByTagName("li")).map(r => r.children[0].children[1].children[0].children[0].textContent).sort().join("\n")
  ```
  
8. Copy the output, from one quotemark to another.
9. Go to your text comparison tool and paste the output on the left. These are your followers in alphabetical order.
10. Open your following list, then repeat Steps 3~8.
11. Go to your text comparison tool and paste the output on the right. These are your followings in alphabetical order.
12. Press "Compare!". All differences between two lists are now highlighted. Time to weed them out!

That pretty much does the trick. Hope you enjoy.

## Wait, does this steal my password?
**Short Answer:** No.

**Long Answer (Viewer discretion is advised):** Let's break down the only script (The alternative one is very similar, explained below) executed during the process:
```js
[].slice.call(document.getElementsByTagName("ul")[2].getElementsByTagName("li")).map(r => r.children[0].children[0].children[1].children[0].textContent).sort().join("\n")
```
To be honest, if you know JavaScript you'll realize that this code doesn't really affect anything: Gets a bunch of elements from the webpage and manipulate it into a list. But not everyone knows JS. I mean if you don't know JS you will probably get confused over whatever that's written below, but for the sake of clarity I sort of broke it down for you and hopefully you can understand it. Don't push yourself tho.
### []
An empty array.
### .slice
[Duplicates the array into a workable JS function.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice)
### .call(...)
[Binds whatever that's inside into this empty array.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)
### document.getElementsByTagName("ul")[2].getElementsByTagName("li")
[Get elements by their tag name.](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByTagName) Apparently, in Instagram, it's the second unordered list. Then we get each list items.
### .map(r => r.children[0].children[0].children[1].children[0].textContent)
[Reorganize the array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) so that we omit any useless information and returns only the usernames. And it has to FOIL the HTML element several times.
### .sort()
[Alphabetical order.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort)
### .join("\n")
Put a line break [between all items in the array and convert it to a string.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join)
