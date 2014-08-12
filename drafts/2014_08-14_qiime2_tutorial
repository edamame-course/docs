---
layout: page
title: "QIIME Tutorial 2"
comments: true
date: 2014-08-14 08:44:36
---
Welcome back, Microbe Enthusiasts!

##Creating an OTU table in QIIME

Previously, we left off with quality-controlled merged Illumina paired-end sequences, picked OTUs and an alignment of the representative sequences from those OTUs.

###3.1  Assign taxonomy to representative sequences**

Navigate into the QIIMETutorial directory using `cd`, and, enter the QIIME environment. We will use the RDP classifier with a greengenes 16S rRNA reference database (both default options in QIIME).  This script will take a few minutes to run on a lap-top. Documentation is [here](http://qiime.org/scripts/assign_taxonomy.html).

```
assign_taxonomy.py -i cdhit_rep_seqs/cdhit_rep_seqs.fasta -m rdp -c 0.8
```
Navigate into the new rdp_assigned_taxonomy directory and inspect the head of the tax_assignments file.
```
head cdhit_rep_seqs_tax_assignments.txt
```

![img11](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial2_IMG/IMG_11.jpg)

This assignment file is used anytime an OTU ID (the number) needs to be linked with its taxonomic assignment.
*Note* that this list of OTUs and taxonomic assignments includes our "failed-to-align" representative sequences.  We will remove these at the next step.

###3.2  Make an OTU table, append the assigned taxonomy, and exclude failed alignment OTUs
The OTU table is the table on which all ecological analyses (e.g. diversity, patterns, etc) is performed.  However, building the OTU table is non-contentious (you just count how many of each OTU was observed in each sample).  Instead, every step up until building the OTU table is important.  The algorithms that are chosen to assemble reads, quality control reads, define OTUs, etc are all gearing up to this one summarization. Documentation for make_otu_table.py is [here](http://qiime.org/scripts/make_otu_table.html). Note that the "map" file is not the actually mapping file, but the OTU cluster file (the output of cdhit).
Navigate back into the "QIIMETutorial" directory to execute the script.
```
make_otu_table.py -i cdhit_picked_otus/combined_seqs_otus.txt -o Schloss_otu_table.biom -e pynast_aligned/cdhit_rep_seqs_failures_names.txt -t rdp_assigned_taxonomy/cdhit_rep_seqs_tax_assignments.txt
```
We used our previously-created list of failed-seq-alignments with the `-e` option to exclude these OTUs.
Inspect the .biom table.
```
head Schloss_otu_table.biom
```
![img12](https://github.com/edamame-course/docs/raw/gh-pages/img/QIIMETutorial2_IMG/IMG_12.jpg)

Be not alarmed! This file is in .biom table format.  Whereas a traditional taxon (OTU) table in ecology is often a matrix of samples (communities) by taxa (OTUs), there are just too many taxa in microbial communities for the traditional table to be efficiently used in computation.  Thus, some of the QIIME folks developed the .biom format.  Documentation about the .biom format is [here](http://biom-format.org/).  If you scroll down on your terminal screen, you will see that the taxonomic assignments were incorporated into the OTU table.

We can get a summary of everything in the .biom OTU table.  **This is an important script.**  Documentation is [here](http://biom-format.org/documentation/summarizing_biom_tables.html)
```
biom summarize_table -i Schloss_otu_table.biom -o summary_Schloss_otu_table.biom
```
###3.2  Sanity check #3
How can we be sure that our failed alignment sequences were excluded from the OTU table?























##Where to find QIIME resources and help
*  [QIIME](qiime.org) offers a suite of developer-designed [tutorials](http://www.qiime.org/tutorials/tutorial.html).
*  [Documentation](http://www.qiime.org/scripts/index.html) for all QIIME scripts.
*  There is a very active [QIIME Forum](https://groups.google.com/forum/#!forum/qiime-forum) on Google Groups.  This is a great place to troubleshoot problems, responses often are returned in a few hours!
*  The [QIIME Blog](http://qiime.wordpress.com/) provides updates like bug fixes, new features, and new releases.
*  QIIME development is on [GitHub](https://github.com/biocore/qiime).

-----------------------------------------------
-----------------------------------------------
