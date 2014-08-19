---
layout: page
title: "Metagenome Annotation"
comments: true
date: 2014-08-19 08:55:36
---

#### **1.** Assembling

At last!  All that filtering and diginorming is done, and we can get
down to the serious business of assembling.  Huzzah!

Let's start with some collection of group files in ``/mnt/assembly``.


##### Install the spades Assembler

Let's try assembling the sequences with the [SPADes](http://bioinf.spbau.ru/spades/).

```
apt-get -y install cmake
```

then:

```
wget http://spades.bioinf.spbau.ru/release2.5.1/SPAdes-2.5.1.tar.gz
tar -xzf SPAdes-2.5.1.tar.gz
cd SPAdes-2.5.1
PREFIX=/usr/local ./spades_compile.sh
```

##### Setting Up The SPAdes run

One of the reasons we are using SPAdes is because it runs an assembly on a set of k-mer values automatically.  It also has a simple structure.

```
spades.py -s sequences.fastq -o assembly
```

This will run for a while!  (We've already done this and will look at the assembly now).

#### Getting Stats For the Assemblies

To get some basic stats for the assemblies, run:

```
python /usr/local/share/khmer/sandbox/assemstats3.py 1000 assembly/scaffolds.fasta
```

This will yield something like:

```
N       sum     max     filename
38      671957  83467   dn.21/contigs.fa
32      668918  83568   dn.23/contigs.fa
35      668509  83401   dn.25/contigs.fa
31      671843  83817   dn.27/contigs.fa
32      669104  83721   dn.29/contigs.fa
32      672735  84066   dn.31/contigs.fa
32      673102  83774   dn.33/contigs.fa
31      674629  83912   dn.35/contigs.fa
31      677446  84200   dn.37/contigs.fa
33      681099  84554   dn.39/contigs.fa
35      685245  84852   dn.41/contigs.fa
40      686733  85276   dn.43/contigs.fa
41      649574  62719   nodn.21/contigs.fa
39      639388  62155   nodn.23/contigs.fa
49      646132  62145   nodn.25/contigs.fa
39      647100  83798   nodn.27/contigs.fa
38      650487  83750   nodn.29/contigs.fa
33      649863  83770   nodn.31/contigs.fa
31      636979  83822   nodn.33/contigs.fa
35      645536  83856   nodn.35/contigs.fa
36      647848  83800   nodn.37/contigs.fa
33      654660  83934   nodn.39/contigs.fa
36      645126  83897   nodn.41/contigs.fa
34      660289  83231   idba.dn.d/scaffold.fa
45      666147  41120   idba.nodn.d/scaffold.fa
```

#### **2.** Annotating your metagenome with Prokka

##### Installing Prokka

I like the [Prokka Annotation Software Program](http://www.vicbioinformatics.com/software.prokka.shtml) to annotate your assembled metagenome.

We have to download and install a lot of stuff, though -- estimated ~15-20 minutes.

First, we need to install BioPerl and NCBI BLAST+; because we're using an Amazon EC2 ubuntu machine, we'll use the Debian Linux package installer `apt-get`.

```
apt-get update
apt-get -y install bioperl ncbi-blast+
```

Now you want to download and unpack Prokka:

```
cd /mnt
curl -O http://www.vicbioinformatics.com/prokka-1.7.tar.gz
tar xzf prokka-1.7.tar.gz 
curl -O http://www.vicbioinformatics.com/prokka-1.7.2
cp prokka-1.7.2 prokka-1.7/bin/prokka
```

Prokka depends on a lot of other software, too; so we'll need to install those tools:

Install [HMMER](http://hmmer.janelia.org):

```
cd /mnt
curl -O ftp://selab.janelia.org/pub/software/hmmer3/3.1b1/hmmer-3.1b1.tar.gz
tar xzf hmmer-3.1b1.tar.gz 
cd hmmer-3.1b1/
./configure --prefix=/usr && make && make install
```

Install [Aragorn](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC373265):

```
cd /mnt
curl -O http://mbio-serv2.mbioekol.lu.se/ARAGORN/Downloads/aragorn1.2.36.tgz
tar -xvzf aragorn1.2.36.tgz
cd aragorn1.2.36/
gcc -O3 -ffast-math -finline-functions -o aragorn aragorn1.2.36.c
cp aragorn /usr/local/bin
```

Install [Prodigal](http://prodigal.ornl.gov):

```
cd /mnt
curl -O http://prodigal.googlecode.com/files/prodigal.v2_60.tar.gz
tar xzf prodigal.v2_60.tar.gz 
cd prodigal.v2_60/
make
cp prodigal /usr/local/bin
```

Install [tbl2asn](http://www.ncbi.nlm.nih.gov/genbank/tbl2asn2):

```
cd /mnt
curl -O ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/converters/by_program/tbl2asn/linux64.tbl2asn.gz
gunzip linux64.tbl2asn.gz 
mv linux64.tbl2asn tbl2asn
chmod +x tbl2asn
cp tbl2asn /usr/local/bin
```

Install [GNU Parallel](<http://www.biostars.org/p/63816/):

```
cd /mnt
curl -O http://ftp.gnu.org/gnu/parallel/parallel-20130822.tar.bz2
tar xjvf parallel-20130822.tar.bz2
cd parallel-20130822/
ls
./configure && make && make install
```

Install [Infernal](http://infernal.janelia.org/):

```
cd /mnt
curl -O http://selab.janelia.org/software/infernal/infernal-1.1rc4.tar.gz
tar xzf infernal-1.1rc4.tar.gz 
cd infernal-1.1rc4/
ls
./configure && make && make install
```

##### Running Prokka at the command line

First we'll use the khmer tool to remove all the sequences with 'N's in them (since prodigal fails if there are too many, and prokka uses prodigal):

```
python /usr/local/share/khmer/sandbox/remove-N.py final-assembly.fa metagenome.fa
```

Now, run Prokka::

```
/mnt/prokka-1.7/bin/prokka metagenome.fa --outdir annotation --prefix assembly --metagenome
```

There will be a bunch of files in the directory `annotation`.  Probably the most interesting is `assembly/assembly.faa`, which will contain a set of
annotated protein sequences derived from the metagenome.

Let's look at some of the files now!

#### **3.** Assessing Assembly Quality with QUAST

We're going to try to get an idea of what our assembly looks like by using the [QUAST (Quality Assessment Tool for Genome Assemblies)](http://bioinf.spbau.ru/quast).

First we need to have some tools installed:

```
sudo apt-get install python-matplotlib
```

```
cd ~
mkdir PROGRAMS
cd PROGRAMS
wget https://downloads.sourceforge.net/project/quast/quast-2.3.tar.gz
tar xzvf quast-2.3.tar.gz
cd quast-2.3
```

The program is installed here, but now we want to run a test to make sure:

```
python metaquast.py --test
```

A bunch of code will pass by, at the end you will see:

```
MetaQUAST finished.
Log saved to /home/ubuntu/PROGRAMS/quast-2.3/quast_test_output/metaquast.log

Finished: 2014-08-19 15:26:24
Elapsed time: 0:00:54.979271
Total NOTICEs: 12; WARNINGs: 0; non-fatal ERRORs: 0

Thank you for using QUAST!
```

...and it passed! Now we don't have to do anything else to have a working QUAST.

We want to now do an assessment of our scaffolds:

```
python metaquast.py -o folder ~/assembly/scaffolds.fasta
```

Now we have a `folder` with our results (it's pretty quick, which is a big plus after the rest of the tools we've used).

Let's look at the files:

```
cd folder/quast_output
ls -la
```

Now you will see:

```
total 96
drwxrwxr-x 4 ubuntu ubuntu  4096 Aug 19 15:37 .
drwxrwxr-x 4 ubuntu ubuntu  4096 Aug 19 15:37 ..
drwxrwxr-x 2 ubuntu ubuntu  4096 Aug 19 15:37 basic_stats
-rw-rw-r-- 1 ubuntu ubuntu  2105 Aug 19 15:37 quast.log
-rw-rw-r-- 1 ubuntu ubuntu 23161 Aug 19 15:37 report.html
drwxrwxr-x 6 ubuntu ubuntu  4096 Aug 19 15:37 report_html_aux
-rw-rw-r-- 1 ubuntu ubuntu 25569 Aug 19 15:37 report.pdf
-rw-rw-r-- 1 ubuntu ubuntu   799 Aug 19 15:37 report.tex
-rw-rw-r-- 1 ubuntu ubuntu   251 Aug 19 15:37 report.tsv
-rw-rw-r-- 1 ubuntu ubuntu   677 Aug 19 15:37 report.txt
-rw-rw-r-- 1 ubuntu ubuntu   704 Aug 19 15:37 transposed_report.tex
-rw-rw-r-- 1 ubuntu ubuntu   251 Aug 19 15:37 transposed_report.tsv
-rw-rw-r-- 1 ubuntu ubuntu   547 Aug 19 15:37 transposed_report.txt
```

We can now look at the HTML report or the PDF report.  You can `scp` these files, or use a method to move files to your computer.

Let's look at the assembly stats.  






