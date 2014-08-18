---
layout: page
title: "Moving data from one program to another"
comments: true
date: 2014-08-18 12:55:36
---

### **1.**  Moving data from QIIME:  converting the .biom table

This command changes frequently, as the biom format is a work in progress.  Use `biom convert -h` to find the most up-to-date arguments and options; the web page is not updated as frequently as the help file.

```
biom convert -b -i Schloss_otu_table_even2212.biom -o Schloss_otu_table_even2212.txt --table-type otu  --header-key taxonomy --output-metadata-id "ConsensusLineage"
```

Here, we use the argument `-b` to specify that we are converting a biom-formatted table to a "classic" otu table.  We specify input and output files with `-i` and `-o`, as always.  We also provide the `--table-type` arugment to "otu."  Finally, we specify that we want our OTU table to have the taxonomy assigned to each OTU as the last column in the table (` --header-key` set to "taxonomy") and that the name of this column, `--output-metadata-id`, will be the "ConsensusLineage"

### **2.**  QIIME to R  : Resemblance tables

For importing resemblance tables
	1.  read.table(header=TRUE, row.names =1; sep =“\t”)
	2.  as.dist()


### **3.** Writing out (exporting) resemblance mtables from R

It is advisable to save resemblance matrices/OTU to a working directory so that we don't have to re-calculate them every time we continue analyses, or if we want to use these matrices in a different program.

Remember that resemblance matrices are actually very long vectors.  R needs to think of these as tables so that it can write them out with the correct delimitations.  Thus, we take the opposite approach as we did when we read in the table. We use the "as.matrix()" command to convert the vector to a table.  Below is an example.

```
braycurtis=as.matrix(braycurtis.d)
```

Then, we use the the "write.table()" command to export the data.  In this command, the first argument is the object that we want to export, the second argument  (given in quotations) is what we want the name of the exported file to be - don't forget the extension, we set row.names and col.names to TRUE because we have both, we specify that we want the exported file to be tab-delimited by setting the sep="\t" argument, and, finally, we specify quote=FALSE, as otherwise R will put every value in the exported table in quotes, which is annoying.  Use the same commands with the Sorenson matrix.

```
write.table(braycurtis, "BrayCurtis_even861.txt",row.names=TRUE, col.names=TRUE,sep="\t", quote=FALSE)
```

```
sorenson=as.matrix(sorenson.d)
```

```
write.table(sorenson, "Sorenson_even861.txt",row.names=TRUE, col.names=TRUE,sep="\t", quote=FALSE)
```

If you open these resemblance matrices in Excel, you will notice another formatting issue.  You must insert a top leftmost cell so that the sample IDs (column names) are shifted one over.  This may seem confusing, but inspect one of the exported files in Excel and everything will be illuminated.

-----------------------------------------------
-----------------------------------------------
