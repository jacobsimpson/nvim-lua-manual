---
title: "Leveraging Awk"
date: 2017-08-25T02:22:43-07:00
draft: true
---

`grep` is a general tool that I use all the time, but recently I've been
thinking I should spend a little more time getting use to `awk` for many of my
common use cases.

Rather than:

```sh
ps -ef | grep "57231"
```

```sh
ps -ef | awk '$2 == 57231'
```

