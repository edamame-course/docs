---
layout: page
title: "Windows Users: Connecting to your EC2 Instance"
comments: true
date: 2014-08-12 18:44:36
---

Windows Users follow these directions to install MobaXterm and access your EC2 Instance:

1. First you will need a terminal to connect via the web.  We recommend you try MobaXTerm.  You can download here: [MobaXterm Terminal](http://mobaxterm.mobatek.net/MobaXterm_Setup_7.1.msi)

Here is a nice [MobaXterm Introduction](http://mobaxterm.mobatek.net/) (if you are interested).

You are also welcome to try the terminal emulator of your choice.

2. Open MobaXterm after it is finished installing
![What MobaXterm looks like](img/moba/mobaxterm.png)

3. Start a new session by clicking on **Session**, then click on **SSH**

4. Under the basic settings, enter the Public DNS from your EC2 Instance. It should look like:
  ec2-**UNIQUE SET OF NUMBERS**.compute-1.amazonaws.com
  (**NOTE:** The unique set of numbers will change each time you start your EC2 Instance.)

5. Check the box next to "Specify username" and fill in the username as "ubuntu"

6. Click the Advanced SSH settings tab and check the box next to "Use private key" and specify the location **key pair** you created when you launched your instance through the Amazon AWS website and then click **"OK"**
![How to start a sesssion](img/moba/start_session.png)

7. SUCCESS! You should now be connected!


-----------------------------------------------
-----------------------------------------------
