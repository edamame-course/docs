---
layout: page
title: "Installing & Connecting Dropbox on your EC2 machine"
comments: true
date: 2014-08-15 18:44:36
---

**IMPORTANT:** If you are a Dropbox user, you can use it to sync and "instantly" move files from your EC2 to your laptop.  This is handy if you need to use the computer power of EC2 to do OTU clustering or chimera checking, but then want to do the less memory intensive stuff on your desktop or laptop computer.

If you are already using Dropbox for a lot of stuff, you might want to create a separate Dropbox account just to deal with your files because they still can add up the memory space.

**1.** Start at the login prompt on your EC2 machine:

```
cd /root
```
If you can not do this ("Permission denied"), make sure you are in
superuser mode. (You should see a text line that starts with something like
 `root@ip-10-235-34-223:~$`. If not, use `sudo bash` to switch.)

**2.** Then, grab the latest dropbox installation package for Linux:

```
wget -O dropbox.tar.gz "http://www.dropbox.com/download/?plat=lnx.x86_64"
```

**3.** Unpack it:

```
tar -xvzf dropbox.tar.gz
```

**4.** Make the Dropbox directory on /mnt and link it in:

```
mkdir /mnt/Dropbox
ln -fs /mnt/Dropbox /root
```

and then run it, configuring it to put stuff in /mnt:

```
HOME=/mnt /root/.dropbox-dist/dropboxd &
```

When you get a message saying "this client is not linked to any account",
copy/paste the URL into browser and go log in.  Voila!

Your directory '/root/Dropbox', or, equivalently, '/mnt/Dropbox', is now
linked to your Dropbox account!
