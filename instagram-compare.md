---
title: I'd like to compare my Instagram followers/followings list!
comments: true
permalink: /instagram-compare
---

**Weed out the fakes!** Here's how to keep your Instagram cool and clean, with this one simple (~~tbh it requires some knowledge~~) trick to effectively compare your followers and followings list, so you can unfollow those traitors who never follows you back!

**REQUIRES A COMPUTER WITH CHROME ON IT.** I tested this method on June 6, if it deprecates please [contact me](https://instagram.com/austinhuang.me).

1. [Log into Instagram](https://instagram.com) **on a computer.**
2. Open [Text Compare!](https://text-compare.com/) on a new tab. (Or any similar service.)
3. Go to your profile, then your follower list.
4. Scroll down the list to the very bottom. (There should not be a white space after the last user.)
5. Click the three dots on the top-right, then "More Tools" > "Developer Tools".
6. Navigate to the "Console" tab of the right sidebar.
7. Paste the following code next to the `>` sign and press <kbd>ENTER</kbd>:
```js
[].slice.call(document.getElementsByClassName("NroHT")).map(r => r.textContent).sort().join("\n")
```
8. Copy the output, from one quotemark to another.
9. Go to the Text Compare! tab and paste the output on the left. These are your followers in alphabetical order.
10. Open your following list, then repeat Steps 3~8.
11. Go to the Text Compare! tab and paste the output on the left. These are your followings in alphabetical order.
12. Press "Compare!". All differences between two lists are now highlighted. Time to weed them out!

That pretty much does the trick. Hope you enjoy.

## Wait, does this steal my password?
No. Let's break down the only script executed on:
```js
[].slice.call(document.getElementsByClassName("NroHT")).map(r => r.textContent).sort().join("\n")
```
### []
An empty array.
### .slice
[Duplicates the array into a workable JS function.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice)
### .call(...)
[Binds whatever that's inside into this empty array.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)
### document.getElementsByClassName("NroHT")
[Get elements by their class value.](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByClassName) Apparently, in Instagram, individual users in the followers/followings list are given the class value `NroHT`. God knows why.
### .map(r => r.textContent)
[Reorganize the array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) so that we omit any useless information and returns only the usernames.
### .sort()
[Alphabetical order.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort)
### .join("\n")
Put a line break [between all items in the array and convert it to a string.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join)
