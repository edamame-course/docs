---
layout: page
title: "Mac OS & Linux Users: Connecting to your EC2 Instance"
date: 2014-08-12 18:44:36
---

Mac OS & Linux Users, connecting to your Amazon EC2 instance at the command line is pretty easy.

1. Open a Terminal:
**MAC Users:** Terminal is under: Applications --> Utilities
**Linux Users:** Press Ctrl + Alt + t

You will need to know the location of your **key pair** you created when you launched your instance.  Usually this will be in your "Downloads" folder, but you may want to move it elsewhere.

You will need to know what your Public DNS is for your EC2 Instance.

2. Enter the following into the terminal:

```
ssh -i **/path/to/your/key/**EDAMAME.pem ec2-user@ec2-**UNIQUE SET OF NUMBERS**.compute-1.amazonaws.com
```

3. SUCCESS! You have now logged into your computer in the cloud!
