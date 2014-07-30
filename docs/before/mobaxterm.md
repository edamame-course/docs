###Windows Users follow these directions to install MobaXterm and access your EC2 Instance

Download [MobaXterm Terminal](http://mobaxterm.mobatek.net/MobaXterm_Setup_7.1.msi)

Here is a nice [MobaXterm Introduction](http://mobaxterm.mobatek.net/) (if you are interested).

* * * 
Open MobaXterm after it is finished installing
![What MobaXterm looks like](https://github.com/KWHall/DataCarpentry/raw/master/Pictures/DataCarpentry/MobaXterm.png)

Click on Session

Click on SSH

* * *
Under the Basic Settings

Enter the Public DNS from your EC2 Instance. It should look like: ec2-**UNIQUE SET OF NUMBERS**.compute-1.amazonaws.com

Check the box next to "Specify username" and fill in the username as "ubuntu"
* * *
Click the Advanced SSH settings tab

Check the box next to "Use private key" and specify the location **key pair** you created when you launched your instance.

Click **"OK"**
![How to start a sesssion](https://github.com/KWHall/DataCarpentry/raw/master/Pictures/DataCarpentry/Start_Session.png)

* * *

###MAC & Linux users 
Open a Terminal 
>  MAC Users: Terminal is under: Applications --> Utilities
>Linux Users: Press Ctrl + Alt + t

You will need to know the location of your **key pair** you created when you launched your instance.

You will need to know what your Public DNS is for your EC2 Instance.

Enter the following into the terminal:
~~~
ssh -i **/path/to/your/key/**EDAMAME.pem ec2-user@ec2-**UNIQUE SET OF NUMBERS**.compute-1.amazonaws.com
~~~

* * *

SUCCESS! You have now logged into your computer in the cloud!
