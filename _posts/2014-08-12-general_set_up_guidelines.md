---
layout: page
title: "Getting Set Up For The Course"
comments: true
date: 2014-08-12 08:55:36
---

One of our major challenges we face in teaching this course is dealing with differences in the computer operating systems.  Most tools for bioinformatics are for Linux based machines.  Also, installing analysis programs and thier dependencies is not always easy.  While we'd like everyone to have working versions of the software on their computers, we realize this is not always possible, so we'll be using both virtual cloud machines as well as your own laptops.  

We'll be using Amazon Web Services for virtual cloud machines during the course.  [Here's a tutorial to get started](https://edamame-course.github.io/docs/intro_to_ec2_instance.html).  We do this for two reasons:

  1. Everyone can use the same machine with the same software installed.  They can use these virtual computers from anywhere they want, as long as they have an internet connection.

  2. Some portions of the data analysis that are memory or processor intensive won't run on a laptop or desktop computer, so you will have to use cloud computing resources such as AWS or your research institution's high performance computer system.


Otherwise, it makes sense for you to use programs on your laptops during the course.


We're going to be using both [QIIME](http://qiime.org/) and [mothur](http://www.mothur.org/) throughout the course.


There are numerous ways to install QIIME.  Please see our tutorials for installation on [MacOSX](https://edamame-course.github.io/docs/extra/macqiime_installation.html).  If you're on a Linux machine, [QIIME installation can be done with package installers](https://github.com/qiime/qiime-deploy).  If you're on a Windows machine, you'll have to install Virtual Box to run a linux machine on top of Windows -- [see our tutorial to do this](https://edamame-course.github.io/docs/QIIME_VB_for_Windows.html).


Please have [mothur installed on your computer](http://www.mothur.org/wiki/Installation). For mothur, please make sure you have the following installed in a single directory that is easy for you to navigate to.
1. [Download and Unpack the correct mothur for your operating system](http://www.mothur.org/wiki/Download_mothur)
2. [Example Dataset from Schloss Lab](http://www.mothur.org/w/images/d/d6/MiSeqSOPData.zip)
3. [SILVA-based bacterial reference alignment](http://www.mothur.org/w/images/9/98/Silva.bacteria.zip)
4. [mothur-formatted version of the RDP training set (v.9)](http://www.mothur.org/w/images/5/59/Trainset9_032012.pds.zip)


You will have to have R installed on your computer: [R](http://www.r-project.org/).  We also recommend [R-Studio](http://www.rstudio.com/).


You'll absolutely need a good text editor.  Here's just a few that we recommend:

1. **Mac OSX**: [TextWrangler](http://www.barebones.com/products/textwrangler/), [Sublime Text](http://www.sublimetext.com/), [Atom](https://atom.io/), [TextMate](http://macromates.com/)

2. **Linux**: [Sublime Text](http://www.sublimetext.com/), [Kate](http://kate-editor.org/), [Geany](http://www.geany.org/), [Atom](https://atom.io/)

3. **Windows**: [NotePad++](http://notepad-plus-plus.org/), [Sublime Text](http://www.sublimetext.com/), [Atom](https://atom.io/), [TextPad](https://www.textpad.com/)


Transfering files at the command line is great (we'll go over this), but sometimes you want to use file transfer software.  Here's a few options:

1. **Mac OSX**: [FileZilla](https://filezilla-project.org/), [ForkLift](http://www.binarynights.com/forklift/)

2. **Linux**: [FileZilla](https://filezilla-project.org/),

3. **Windows**: [Filezilla](https://filezilla-project.org/), [WinSCP](http://winscp.net/download/winscp554setup.exe)


If you're using a Windows machine, please install [GitBash](http://git-scm.com/downloads) for the tutorials about using the command line.


**Important:** If at any point, you're lost about all of this installation stuff, don't worry.  We'll be available on [Tuesday, August 12th, in the evening](https://edamame-course.github.io/website/schedule.html) to help you out.  We'll also have plenty of time throughout the course to get everything working for you.


----------------------------------------------------
----------------------------------------------------
