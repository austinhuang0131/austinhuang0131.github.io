---
title: BVE Trainsim 5 Survival Guide (Windows & Mac)
description: Wanna actually play a realistic train simulator FOR FREE? Try BVE 5! Includes Mac installation and recommended scenarios.
comments: true
permalink: /bve
---

Aight, so hear me out: These train simulators on Steam really cost. Like $30+. Honestly, maybe they're better in the 3D graphics, but BVE Trainsim 5 could score much better in performance than these costly alternatives.

## Install
### Windows
Read official instructions and downloads [here](http://bvets.net/en/download/).

### Mac
Yes, you can run BVE 5 **on a Mac**. Referenced [this blog post](https://kakurasan.blogspot.com/2015/07/bve-trainsim-on-wine.html) (Japanese).

**Known Issues:** Can't show Japanese characters at all. I tried `LANG=ja_JP.UTF-8`, `LANG=ja_JP.Shift_JIS` and `LC_ALL=ja_JP` in Runtime Arguments. If you could solve this, please please please leave a comment below.

1. [Get WineBottler.](http://winebottler.kronenberg.org/) (2.0 is fine.) Load the disk image, drag both WineBottler and Wine to the Applications folder. (Non-Sudo people: Or any folder you like - I drag to the Downloads folder. But both apps should be in the same folder. I didn't try otherwise.)
2. [Get BVE 5 WITHOUT INSTALLER.](http://bvets.net/en/download/zip.html) Unzip it.
3. Launch WineBottler.
4. Click Advanced.
5. For Program Installation, select the `BveTs.exe` in the folder.
6. For Installation mode, select "copy file (program) and all files in the folder to the App Bundle."
7. For System Version Info, select 7. (BVE 5 requires Vista or higher.)
8. You MUST tick "Include Mono". (Or you'll be forced to exit with an error log, as you cannot get `dotnet35`.) I didn't tick "Include Gecko", but I think it's okay if you leave it on.
9. For Winetricks, find the following and tick them: `dotnet35` (MS .NET 3.5), `d3dx9_43` (MS d3dx9_43.dll), and `mdx` (Managed DirectX).
10. Tick Silent Install.
11. Press Install, set file name, and go. Takes like 2 minutes to install, then you get an .app bundle. Off you go!

No, I'm not giving you my pre-bundled app. Probably goes against some rules about sharing.

## Basic control
[http://bvets.net/en/drive/index.html](http://bvets.net/en/drive/index.html)

All number keys on that page are Numpad keys, which are useless on Mac (Use your mouse to drag instead). They do not conflict with ATS/ATC stuff below.

## (WIP) Scenarios
Yes yes, I know many English scenarios are made in BVE 4 or OpenBVE. I know [Converter](http://bvets.net/en/download/conv.html) exists, but isn't it better to play scenarios that actually support 5, without the need to solve bugs?
* Windows users: Place all Scenarios in `C:\users\<name>\My Documents\BveTs\Scenarios`.
* Mac users: Place all Scenarios in `/Users/<name>/Documents/BveTs/Scenarios` (which is equivalent to `~/Documents/BveTs/Scenarios`).

All scenarios should contain 1 folder and a bunch of TXT files (Which tells BVE what route to drive) outside the folder. If there's only 1 folder with nothing else, either it's a Vehicle file (I'll indicate) or you forgot to look inside when you unzip.

I have tested all the scenarios below. ATS/ATC instructions are included. (Many people can't figure out how to even start their train, as most instructions are in Japanese. I can read Japanese, at least.)

### List
* mackoy: [Keisei Chihara Line](#keisei-chihara-line)
* neclgm: [Tama Toshi Monorail](#tama-toshi-monorail) (E) (ATC)
* wackey: [Keihan Keishin Line](#keihan-keishin-line) (PE) (ATS)
* Green Shuttle:
  * [Hanzomon Line](#trta-then-tokyo-metro-hanzomon-line) (ATC-Usao)
  * [Ginza Line](#trta-then-tokyo-metro-ginza-line) (ATC-Usao)
  * Fukutoshin Line (ATC-Usao)
  * Tokyo Monorail
* Bluegill77: [Osaka Metro Yotsubashi Line](#osaka-metro-yotsubashi-line) (ATC-Usao)
* L53: [Kyoto Municipal Subway Karasuma Line](#Kyoto-Municipal-Subway-Karasuma-Line) (ATC)

#### Legend
* (P): Permission obtained for posting.
* (E): English
* (PE): Partially English (Usually station names)
* (ATS): Automatic Train Stop (If you go over speed limit, it'll immediately stop your train)
* (ATC): Automatic Train Control (If you go over speed limit, it'll brake to enforce that speed limit, only constant violations will stop your train)
  * (ATC-Usao): Usao's [Metro General Plugin](http://nozomi.vc/71_ats/index.htm)
  * Other (ATC): Custom-coded

### Keisei Chihara Line
The official one. Download [here](http://bvets.net/en/download/zip.html), no additional stuff required. Here's a walkthrough:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/ocRex0a2jUI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Tama Toshi Monorail
Download [here](http://neclgm.blog.fc2.com/blog-entry-58.html). Both the page AND THE SCENARIO is **in English**!

To start the train from the terminus, you'll need to press ATS 0 (S) - ATS 13 (J) - ATS 4 (B2), BEFORE releasing the emergency brake or touching the reverser. Your train WILL NOT MOVE if you don't do so.
* On Windows, that is <kbd> SPACE </kbd> - <kbd>8</kbd> - <kbd>END</kbd>. You can also press <kbd>Delete</kbd> for a list of key assignments specific to that scenario.
* On Mac, or if your Windows computer does not have an <kbd>END</kbd> key, you'll need to reassign keys. Right click => Preferences => Input device => Key assignments... => Switches => Find "ATS 4 (B2)" => Press the On/Off box below => Press the key you want to assign (Fn combos accepted, no other combos). If you want to show the in-game key assignment list (Just this game), you'll need to reassign "ATS 2 (A2)" as well.
* Here's a walkthrough:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/u58bNLPdQew" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Keihan Keishin Line
Detailed scenary means it's **Resource-Heavy! Requires good GPU!!!**

Download [here](https://www.like-a-lake.com/bve-keihan-keishin/). Find "Mirror site(yahoo box)" and you'll see two columns: The left with Installer, the right without. You'll also see a OneDrive link and a Yahoo Box (Japanese) link.

* Station names are in English. [The manual](https://www.like-a-lake.com/bve-keihankeishin-drive.html) is in Japanese, but the pictures are in English.
* Mac users: Ignore errors when loading the scenario, they don't affect the gameplay that much. Tested multiple times.
* To start the train from the terminus, you'll need to press <kbd>5</kbd> to enable ATS (Or you will not be able to drive - The line does not have ATO), and switch the reverser to the front. Then, **remain on Emergency Brake** until you're told to depart by the screen message (Or ATS will stop you, reason unknown. If you forgot this: Get back on P0 AND Emergency Brake (By pressing <kbd>/</kbd>), then release it again).
* Seriously, **abide speed limit.** This is ATS, not ATC, and Deadman's Switch gets activated extremely often, which will give you a big delay off your schedule.
  * IF there's a red light in the bottom-left corner, you're screwed: You just triggered ATS. To release, Get back on P0 AND Emergency Brake (By pressing <kbd>/</kbd>), then <kbd>6</kbd> (Disable ATS) + <kbd>5</kbd> (Enable ATS).
* Here's a walkthrough:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/Zcpggd-N0pM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### TRTA (then-Tokyo Metro) Hanzomon Line
Download [here](http://shtr-m.net/bve/hanzomon.html). Click the first link wrapped by `>><<` in the first heading. Everything's in Japanese.

For this scenario, you'll need to download vehicles.
1. Go [here](http://vertah.sakura.ne.jp/bvedata/train.html).
2. You need 8000, 08, 8590, and 30000. (For TKK 2000, download [here](http://bve.jpn.org/tokyu2000.html) instead, but it's an EXE file.)
3. Click the link at the bottom of each box.
4. For 8000: The download link is in the purple box at the bottom of the page. For others: First text link in the second-last box at the bottom.
5. Unzip them and place them in `.../Scenarios/vertah`.

* To start E/B1056T (Red background, brown train) from the overground terminus, you'll need to press <kbd>8</kbd> **ONCE** to enable ATS for Tobu when remaining in `N EB`. Then, after arriving at the first underground station, you'll need to get back to `N EB` and press <kbd>8</kbd> **ONCE** again to enable ATC for Metro.
* To start C/B1367S (Red background, purple train) from the overground terminus, you'll need to press <kbd>8</kbd> **TWICE** to enable ATS for Tobu when remaining in `N EB`. Then, after arriving at the first underground station, you'll need to get back to `N EB` and press <kbd>7</kbd> **ONCE** then <kbd>8</kbd> **ONCE** to enable ATC for Metro.
* To start B952T (No background, brown train) from the underground terminus, you'll need to press <kbd>8</kbd> **TWICE** to enable ATC for metro when remaining in `N EB`.
* To start all other trains from the underground terminus, you'll need to press <kbd>8</kbd> **ONCE** to enable ATC for Metro when remaining in `N EB`.
* B953S is a Not-in-Service train which passes all stations. All others stop at all stations.
* Press <kbd>0</kbd> for speedometer lights, <kbd>9</kbd> for wiper (If train has it).
* Here's a walkthrough for E/B1056T:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/XDeNjNsnG4I" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### TRTA (then-Tokyo Metro) Ginza Line
Download [here](http://shtr-m.net/bve/ginza.html). Click the first link wrapped by `>><<` in the first heading. Everything's in Japanese. You need to [download vehicles](http://vertah.sakura.ne.jp/bvedata/trta01.html) as well and place them in `.../Scenarios/vertah`.

* To start the train, you'll need to press <kbd>8</kbd> **ONCE** to enable ATC for Metro when remaining in `N P0 EB`.
* Press <kbd>0</kbd> for speedometer lights, <kbd>9</kbd> for wiper.
* Here's a walkthrough:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/tlDv4FQQcd4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Tokyo Metro Fukutoshin Line
Under testing...

### Tokyo Monorail
Under testing...

### Osaka Metro Yotsubashi Line
Download [here](https://iyoiyokohei.wixsite.com/bluegill77/bveyotsubashi-download). For the vehicle, download [here](https://yahoo.jp/box/oLvw3q). ([Vehicle documentation](https://tetsudo-1998.jimdo.com/bve/%E8%BB%8A%E4%B8%A1%E3%83%87%E3%83%BC%E3%82%BF/))

* To start the train, you'll need to press <kbd>7</kbd> **ONCE** to enable ATC for Metro when remaining in `N P0 EB`. **DO NOT** press <kbd>7</kbd> or <kbd>8</kbd> again as it'll disable your train (And I don't see a remedy currently without re-opening the scenario).
* Here's a walkthrough:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/_5xXPNKVxsg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Kyoto Municipal Subway Karasuma Line
Download [here](https://blogs.yahoo.co.jp/l53_fmkr/27211920.html). Vehicles included.

* There is an ATC, but no key is required as it is enabled at all times.
* The driver cab graphics for Train 149 is significantly better than Train 145.
* Here's a walkthrough:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/rWPix3SJKXo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Kurumadome (Buffer Stop)
For any issues, please [contact me](https://austinhuang.me/contact) or comment below. I can respond in Mandarin or English. Japanese emails will be accepted (I can read Japanese, didn't I tell you that?) but I'll only reply in English.
