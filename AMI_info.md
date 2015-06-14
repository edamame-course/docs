---
title: AWS ami information
layout: post
date: June 11th, 2015
category : information
tags : [tutorials, information]
---
{% include JB/setup %}

Our AWS ami can be found by searching for `EDAMAME-2015` or `ami-af04f2c4`.  [See this page for help](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/usingsharedamis-finding.html) on finding public AMIs.

**Here's what on the AMI and everything *should* be playing well together:**

Everyday packages installed from scratch:
R (only extras are base packages used by QIIME & mothur)
abyss
aragorn
autoconf
automake
bamtools
barrnap
bedtools
bio-awk
biom
bison
blast
boost
bowtie
bwa
bzip2
cmake
curl
expat
gcc
gmp
google-sparsehash
hmmer
htslib
infernal
isl
jpeg
libmpc
libpng
libtool
makedepend
megahit
mpfr
openssl
parallel
pcre
pkg-config
prodigal
prokka
quast
samtools
seqtk
spades
tbl2asn
tcl-tk
trinity
velvet
xz

**Python Packages**
alabaster==0.7.4
awscli==1.7.32
Babel==1.3
backports.ssl-match-hostname==3.4.0.2
BamM==1.4.1
bcdoc==0.15.0
biom-format==2.1.4
botocore==1.0.0b1
burrito-fillings==0.1.1
burrito==0.9.1
bz2file==0.98
certifi==2015.4.28
Cheetah==2.4.4
cogent==1.5.3
colorama==0.3.3
Cython==0.22
docutils==0.12
dumbo==0.21.35
emperor==0.9.51
future==0.14.3
gdata==2.0.18
GnuPGInterface==0.3.2
ipython==3.1.0
Jinja2==2.7.3
jmespath==0.7.1
lazr.uri==1.0.3
Markdown==2.6.2
MarkupSafe==0.23
matplotlib==1.4.3
mock==1.0.1
natsort==3.5.6
nose==1.3.7
numexpr==2.4.3
numpy==1.9.2
numpydoc==0.5
oauth==1.0.1
PAM==0.4.2
pandas==0.16.1
PrimerProspector===1.0.1-release
pyasn1==0.1.7
pyfasta==0.5.2
Pygments==2.0.2
pynast==1.2.2
pyparsing==2.0.3
pyqi==0.3.2
python-apt===0.8.3ubuntu7.3
python-dateutil==2.4.2
pytz==2015.4
qcli==0.1.1
qiime-default-reference==0.1.3
qiime==1.9.1
rsa==3.1.4
scikit-bio==0.2.3
scikits.statsmodels==0.3.1
scipy==0.15.1
screed==0.8
six==1.9.0
snowballstemmer==1.2.0
sphinx-rtd-theme==0.1.8
Sphinx==1.3.1
tax2tree==1.0
Twisted-Core==11.1.0
typedbytes==0.3.8
ufw==0.31.1.post1

**1450 Perl Packages** (not going to list them here -- ask me if you can't find something and I will point you in the right direction)

Please test the AMI with your tutorials and data and if you run into any errors, please open an issue.

When you open the issue, please provide me with two things:
1. The exact code you ran that gave you the error
2. The response to the screen that you received

Those things will help me to fix any problems.  Thanks! ~ josh
