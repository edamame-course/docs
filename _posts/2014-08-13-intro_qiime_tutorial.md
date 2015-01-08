---
layout: page
title: "Intro to QIIME"
comments: true
date: 2014-08-13 08:44:36
---
###Handouts of workflow charts are available for the QIIME workflow discussed in these tutorials:
-  [Paired-End Illumina](https://github.com/edamame-course/docs/tree/gh-pages/extra/Handouts/QIIMEFlowChart_IlluminaPairedEnds_13aug2014.pdf?raw=true)
-  [454](https://github.com/edamame-course/docs/tree/gh-pages/extra/Handouts/QIIMEFlowChart_454_13aug2014.pdf?raw=true)

## Getting started

Make a new directory `mkdir` in which to put all of your QIIME-related analyses for today and tomorrow, and then 'cd' to move into that directory.  Execute all commands from within this directory.

```
mkdir QIIMETutorial
```

```
cd QIIMETutorial
```

## Assembling Illumina paired-end sequences

### 1.1  Download Schloss mouse data
These data are 16S rRRNA V4 amplicons sequenced with MiSeq technology:  

*If you are a Mac user*, about half-way down the page, click on [Example data from Schloss lab - http://www.mothur.org/wiki/MiSeq_SOP](http://www.mothur.org/wiki/MiSeq_SOP).  

  ![img1](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_01.jpg).

  Unzip (the directory with the data will be called MiSeq_SOP) and move it into the "QIIMETutorial" directory.  

*If you are on the EC2 or the QIIME Virtual Box*, download the Schloss data from the terminal, using `wget` :  

```
wget http://www.mothur.org/w/images/d/d6/MiSeqSOPData.zip  
```

```
unzip MiSeqSOPData.zip  
```

This will make the directory "MISeq_SOP."  Move this into the QIIMETutorial directory.

### 1.2  Use `mkdir` to create a new directory called "pandaseq_merged_reads"

```
mkdir pandaseq_merged_reads
```

### 1.3  Join paired end Illumina reads with PANDAseq**
```
pandaseq -f MiSeq_SOP/F3D0_S188_L001_R1_001.fastq -r MiSeq_SOP/F3D0_S188_L001_R2_001.fastq -w pandaseq_merged_reads/F3D0_S188.fasta -g pandaseq_merged_reads/F3D0_S188.log -L 255 -t 0.90
```
Let's look carefully at the anatomy of this command.

  -  `pandaseq` calls the package of pandaseq scripts.
  -  `-f MiSeq_SOP/F3D0_S188_L001_R1_001.fastq` tells the script where to find the forward read.
  -  `-r` tells the script where to find its matching reverse read.
  -  `-w pandaseq_merged_reads/F3D0_S188.fasta` directs the script to make a new fasta file of the assembled reads and to put it in the "pandaseq_merged_reads" directory.
  -  `-g pandaseq_merged_reads/F3D0_S188.log` Selects an option of creating a log file.
  -  `-L` specifies the maximum length of the assembled reads, which, in truth, should be 251 bp. This is a very important option to specify, otherwise PANDAseq will assemble a lot of crazy-long sequences.

  All of the above information, and more options, are fully described in the [PANDAseq Manual.](http://neufeldserver.uwaterloo.ca/~apmasell/pandaseq_man1.html).  The log file includes details as to how well the merging went.

### 1.4  Sanity check #1 and file inspection.

There are some questions you may be having: What does pandaseq return?  Are there primers/barcodes on the assembled reads?  Are these automatically trimmed?

  It turns out, that PANDAseq, by default, removes primers and barcodes (There are also options to keep primers, please see the manual link above).  Given that we used the default pandaseq options, how do we check to make sure that what we expect to happen actually did happen?

  We know the V4 forward primer sequence that the Schloss lab used because these sequences are provided in Kozich et al. 2013.

Here is the V4 primer sequence : GTCCAGCMGCCGCGGTAA

  We can search for that sequence in the assembled sequence file, using the `grep` function.  

```
cd pandaseq_merged_reads
```

```
head F3D0_S188.fasta
```

![img2](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_02.jpg)  

```
grep GTCCAGCMGCCGCGGTAA F3D0_S188.fasta
```

When you execute the above command, the terminal does not return anything.  This means that the primer sequence was not found in the file, suggesting that PANDAseq did, in fact, trim them.

We can double check our sanity by using a positive control.  Let's use `grep` to find a character string that we know is there, for instance the "M00967" string identifying the first sequence.

```
grep M00967 F3D0_S188.fasta
```

Whoa!  That is hard to read all of those lines. Let's put the results into a list by appending `> list.txt` to the command.  The ">" symbol means to output the results to a new file, which is specified next.  


```
grep M00967 F3D0_S188.fasta > list.txt
```

This creates a new file called "list.txt", in which all instances of the character string "M00967" are provided.  Let's look at the head.

```
head list.txt
```

![img3](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_03.jpg)  

Our positive control worked, and we should be convinced and joyous that we executed `grep` correctly AND that the primers were trimmed by PANDAseq.  We can now remove the list file.

```
rm list.txt
```

### 1.5  Automate paired-end merging with a shell script.

We would have to execute an iteration of the PANDAseq command for every pair of reads that need to be assembled. This could take a long time.  So, we'll use a shell script to automate the task.  

Download this [list](https://github.com/edamame-course/docs/raw/gh-pages/misc/QIIMETutorial_Misc/SchlossSampleNames.txt) (*VB/EC2 users*, use `wget`) of all the unique sample names and move it to your QIIMETutorial directory.  

Then, download this shell [script](https://github.com/edamame-course/docs/raw/gh-pages/misc/QIIMETutorial_Misc/pandaseq_merge.sh) (*VB/EC2 users*, use `wget`) and move it to your QIIMETutorial directory.  

Change permissions on the script

```
chmod +x pandaseq_merge.sh
```

Execute the script from the QIIMETutorial Directory.

```
./pandaseq_merge.sh
```

### 1.6  Sanity check #2.

How many files were we expecting from the assembly?  There were 19 pairs to be assembled, and we are generating one assembled fasta and one log for each.  Thus, the pandaseq_merged_reads directory should contain 38 files.  We use the `wc` command to check the number of files in the directory.

```
ls -1 pandaseq_merged_reads | wc -l
```

The terminal should return the number "38."  Congratulations, you lucky duck! You've assembled paired-end reads!  

![img4](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_04.jpg)  

## Moving assembled reads into the QIIME environment

While working through the tutorial, open your web browser and navigate to this [page](http://www.qiime.org/scripts/index.html). It provides an index of qiime scripts and options.  We will be using the default for most of the time, but for each script, it is useful to open its documentation and assess the alternative options.

### 2.1  Understanding the QIIME mapping file.
QIIME requires a [mapping file](http://qiime.org/documentation/file_formats.html) for most analyses.  This file is important because it links the sample IDs with their metadata (and, with their primers/barcodes if using QIIME for quality-control). Because we are super-amazing, we've already created a mapping file for the Schloss data for you.  [Download it](https://github.com/edamame-course/docs/raw/gh-pages/misc/QIIMETutorial_Misc/Schloss_Map.txt) (*VB/EC2* users, use `wget`), and move it to your QIIMETutorial directory.

Let's spend few moments getting to know the mapping file:

```
more Schloss_Map.txt
```

![img5](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_05.jpg)  

A clear and comprehensive mapping file should contain all of the information that will be used in downstream analyses.  The mapping file includes both categorical (qualitative) and numeric (quantitative) contextual information about a sample. This could include, for example, information about the subject (sex, weight), the experimental treatment, time or spatial location, and all other measured variables (e.g., pH, oxygen, glucose levels). Creating a clear mapping file will provide direction as to appropriate analyses needed to test hypotheses.  Basically, all information for all anticipated analyses should be in the mapping file.

*Hint*:  Mapping files are also a great way to organize all of the data for posterity in the research group.  New lab members interested in repeating the analysis should have all of the required information in the mapping file.  PIs should ask their students to curate and deposit both mapping files and raw data files.

Guidelines for formatting map files:
  - Mapping files should be tab-delimited
  - The first column must be "#SampleIDs" (commented out using the `#`).
  -  SampleIDs are VERY IMPORTANT. Choose wisely! Ideally, a user who did not design the experiment should be able to distiguishes the samples easily, as is the case with the Schloss data. SampleIDs must be alphanumeric characters or periods.  They cannot have underscores.
  - The last column must be "Description".
  - There can be as many in-between columns of contextual data as needed.
  - If you plan to use QIIME for quality control (which we do not need because the PANDAseq merger included QC), the BarcodeSequence and LinkerPrimer sequence columns are also needed, as the second and third columns, respectively.
  - Excel can cause formatting heartache.  See more details [here](misc/QIIMETutorial_Misc/MapFormatExcelHeartAche.md).

### 2.2  Call QIIME

For Mac users, to enter the QIIME environment in all of its glory, use `macqiime`.

A good command to know is:

```
print_qiime_config.py
```

![img9](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_09.jpg)  


This will give you really important information about versions of software, etc.  You will need this info

### 2.3  Merging assembled reads into the one big ol' data file.

QIIME expects all of the data to be in one file, and, currently, we have one separate fastq file for each assembled read.  We will add labels to each sample and merge into one fasta using the `add_qiime_labels.py` script. Documentation is [here](http://qiime.org/scripts/add_qiime_labels.html).

```
add_qiime_labels.py -i pandaseq_merged_reads/ -m Schloss_Map.txt -c InputFileName -n 1 -o combined_fasta
```

This script creates a new directory called "combined_fasta."  Use `cd` and `ls` to navigate to that directory and examine the files.  Inspect the new file "combined_seqs.fna."

```
head combined_seqs.fna
```

![img6](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_06.jpg)  


Observe that QIIME has added the SampleIDs from the mapping file to the start of each sequence.  This allows QIIME to quickly link each sequence to its sampleID and metadata.

While we are inspecting the combined_seqs.fna file, let's confirm how many sequences we have in the dataset.

```
count_seqs.py -i combined_seqs.fna
```

This is a nice QIIME command to call frequently, because it provides the total number of sequences in a file, as well as some information about the lengths of those sequences.  But, suppose we wanted to know more than the median/mean of these sequences?

Another trick with QIIME is that you can call all the mothur commands within the QIIME environment, which is very handy.  mothur offers a very useful command called `summary.seqs`, which operates on a fasta/fna file to give summary statistics about its contents.  We will cover mothur in all its glory later, but for now, execute the command:

```
mothur
```

```
summary.seqs(fasta=combined_seqs.fna)
```

Note that both summary.seqs and count_seqs.py have returned the same total number of seqs in the .fna file.  Use the following command to quit the mothur environment and return to QIIME.  

![img](img/QIIMETutorial1_IMG/summary_seqs.jpg)

```
quit()
```

##### 2.3.2  Optional step* :  chimera checking with USEARCH before picking OTUs.  USEARCH is an add-on to MacQIIME (extra installation steps required).

### 2.4  Picking Operational Taxonomic Units, OTUs.
Picking OTUs is sometimes called "clustering," as sequences with some threshold of identity are "clustered" together to into an OTU.

  *Important decision*: Should I use a de-novo method of picking OTUs or a reference-based method, or some combination? ([Or not at all?](http://www.mendeley.com/catalog/interpreting-16s-metagenomic-data-without-clustering-achieve-subotu-resolution/)). The answer to this will depend, in part, on what is known about the community a priori.  For instance, a human or mouse gut bacterial community will have lots of representatives in well-curated 16S databases, simply because these communities are relatively well-studied.  Therefore, a reference-based method may be preferred.  The limitation is that any taxa that are unknown or previously unidentified will be omitted from the community.  As another example, a community from a lesser-known environment, like Mars or a cave, or a community from a relatively less-explored environment would have fewer representative taxa in even the best databases.  Therefore, one would miss a lot of taxa if using a reference-based method.  The third option is to use a reference database but to set aside any sequences that do not have good matches to that database, and then to cluster these de novo.

We use the `pick_otus.py` script in QIIME for this step.  Documentation is [here](http://qiime.org/scripts/pick_otus.html?highlight=pick_otus).
The default QIIME 1.8.0 method for OTU picking is uclust (de novo, but there is a reference-based alternative, see below), but we will use the CD-HIT algorithm (de novo).  However, we encourage you to explore different OTU clustering algorithms to understand how they perform.  They are not created equal.  Honestly, we are using CD-HIT here because because it is fast.

Make sure you are in the QIIMETutorial directory to start.  This will take a few (<10ish) minutes.

```
pick_otus.py -i combined_fasta/combined_seqs.fna -m cdhit -o cdhit_picked_otus/ -s 0.97 -n 100
```

In the above script:
  - We tell QIIME to look in the "combined_fasta" directory for the input file `-i`, "combined_seqs.fna".
  - We chose the clustering method CD-HIT `-m`
  - We defined an output file "cdhit_picked_otus" `-o`.  Names of output files are important, because there are many options for each analysis. Using the algorithm choice in the directory name is key for comparing the output of multiple algothims (for instance, if you wanted to compare how picking OTUs with CD-HIT and with uclust may influence your results.)
  - We define OTUs at 97% sequence identity `-s 0.97`
  - We opt for a pre-filtering step, unique to CD-HIT `-n` = 100.

Inspect the log and the resulting combined_seqs_otus.txt file, using `head`.  You should see an OTU ID (yellow box), starting at "0" the the left most column.  After that number, there is a list of Sequence IDs that have been clustered into that OTU ID.  The first part of the sequence ID is the SampleID from which it came (green box), and the second part is the sequence number within that sample (purple box).  

![img7](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_07.jpg)

From the head of the combined_seqs_otus.txt file, we can see that OTU 0 has many sequence associated with it, including sequence 9757 from from sample F3D8.S196. We also see that OTU 3 only has one sequence associated with it. The log file has goodies about the algorithm and options chosen.  Keep this (and all) log file, because when you are writing the paper you may not remember what version of which clustering algorithm you used.

### 2.5  Pick a representative sequence from each OTU.

Representative sequences are those that will be aligned and used to build a tree.  They are selected as the one sequence, out of its whole OTU cluster, that will "define" its OTUs. As you can imagine, understanding how these "rep seqs" are chosen is very important.  Here, we will use the default method (the first sequence listed in the OTU cluster) of QIIME's `pick_rep_set.py` script; documentation [here](http://qiime.org/scripts/pick_rep_set.html).

```
mkdir cdhit_rep_seqs/
```

```
pick_rep_set.py -i cdhit_picked_otus/combined_seqs_otus.txt -f combined_fasta/combined_seqs.fna -o cdhit_rep_seqs/cdhit_rep_seqs.fasta -l cdhit_rep_seqs/cdhit_rep_seqs.log
```

As before, we specify the input files (the script needs the OTU clusters and the raw sequence file as input), and then we additionally specified the a new directory for the results.
Inspect the head of the new fasta file, cdhit_rep_seqs.fasta.


![img8](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_08.jpg)

As before, we see the OTU ID given first (consecutively, starting with 0), and then the sequence ID of the representative sequence, and then the full nucleotide information for the sequence. Notice that for OTU 0, which only had one sequence in its "cluster", is defined by that one sequence.  Don't be shy - go ahead and compare it to the combined_seqs_otus.txt file of OTU clusters.

Take a gander at the log file, as well.  

### 2.6 Align representative sequences.

Navigate back to the QIIMETutorial directory. We will align our representative sequences using PyNAST, which uses a "gold" reference template for the alignment.  QIIME uses a "gold" pre-aligned template made from the greengenes database.  The default alignment to the template is minimum 75% sequence identity and minimum length 150. The default minimum length is not great for short reads like we have, so we will be more generous and change the default. What should we change it to?

```
count_seqs.py -i cdhit_rep_seqs/cdhit_rep_seqs.fasta
```

Given that our average assembled read length is ~252 bp, let's decide that at least 100 bp must align.  We will have the `-e` option to 100. The alignment will take a few minutes.  Documentation for `align_seqs.py` is [here](http://qiime.org/scripts/align_seqs.html).

```
align_seqs.py -i cdhit_rep_seqs/cdhit_rep_seqs.fasta -o pynast_aligned/ -e 100
```

Navigate into the pynast_aligned directory.  There are three files waiting there:  one file of sequences that failed to align, one of sequences that did align, and a log file.  Inspect each.

```
count_seqs.py -i cdhit_rep_seqs_failures.fasta
```

```
count_seqs.py -i cdhit_rep_seqs_aligned.fasta
```

We see that there were ~3 rep. sequences that failed to align, and approximately 682 that did.  (Also, notice what short-read alignments generally look like...not amazing).

*Sanity check?*  If you like, [BLAST](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastSearch&BLAST_SPEC=MicrobialGenomes) the top sequence that failed to align to convince yourself that it is, indeed, a pitiful failure.

If, in the future, you ever have a large proportion of rep seqs that fail to align, it could be due to:
  *  Hooray! These are novel organisms! (But, think about the habitat before jumping to conclusions. As lucky as we would be to discover new species in the mouse gut, this is unlikely.)
  *  The alignment parameters were too stringent for short reads, causing "real" sequences to fail alignment.
  * The paired-end merger algorithm (e.g., pandaseq) did not do a perfect job, and concatenated ends that do not belong together.
  * Some combination of the above, as well as some other scenarios.

We will filter out these failed-to-align sequences (really, the removing the entire OTU cluster that they represent) from the dataset after we make the OTU table.  In the meantime, let's create a text file of all the names of the rep. sequence OTU IDs that we want to remove.  We only have three failures, so we easily could do it by hand.  What if we had more?  Here's how to automate the generation of the "cdhit_rep_seqs_failures_names.txt" file using the `grep` command. We will not go into details, but general grep help is [here](http://unixhelp.ed.ac.uk/CGI/man-cgi?grep). Navigate back into the QIIMETutorial directory to run the grep command.

```
grep -o -E "^>\w+" pynast_aligned/cdhit_rep_seqs_failures.fasta | tr -d ">" > pynast_aligned/cdhit_rep_seqs_failures_names.txt
```

Congratulations!  You just had the QIIME of Your Life!

![img10](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial1_IMG/IMG_10.jpg)  


## Where to find QIIME resources and help
  - [QIIME](qiime.org) offers a suite of developer-designed [tutorials](http://www.qiime.org/tutorials/tutorial.html).
  - [Documentation](http://www.qiime.org/scripts/index.html) for all QIIME scripts.
  - There is a very active [QIIME Forum](https://groups.google.com/forum/#!forum/qiime-forum) on Google Groups.  This is a great place to troubleshoot problems, responses often are returned in a few hours!
  - The [QIIME Blog](http://qiime.wordpress.com/) provides updates like bug fixes, new features, and new releases.
  - QIIME development is on [GitHub](https://github.com/biocore/qiime).

-----------------------------------------------
-----------------------------------------------
