---
layout: page
title: "Installing & Connecting to Dropbox on your EC2 machine (or any machine)"
comments: true
date: 2014-08-15 18:44:36
---

**IMPORTANT:** If you are a Dropbox user, you can use it to sync and "instantly" move files from your EC2 to your laptop (and vice versa).  This is handy if you need to use the computer power of EC2 to do OTU clustering or chimera checking, but then want to do the less memory intensive stuff on your desktop or laptop computer.

If you are already using Dropbox for a lot of stuff, you might want to create a separate Dropbox account just to deal with your files because they still can add up the memory space.

**1.** Go to your user directory by entering:

```
cd
```

**2.** Grab the latest dropbox installation package for Linux:

```
wget -O dropbox.tar.gz "http://www.dropbox.com/download/?plat=lnx.x86_64"
```

**3.** Unpack it:

```
tar -xvzf dropbox.tar.gz
```

**4.** and then run it, configuring it to put stuff in and connect it to your Dropbox:

```
.dropbox-dist/dropboxd &
```

When you get a message saying "this client is not linked to any account",
copy/paste the listed URL into a web browser and log in.  Voila!  You're connected!

Your directory is now linked to your Dropbox account!
