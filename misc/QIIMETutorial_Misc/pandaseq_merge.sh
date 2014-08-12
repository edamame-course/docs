#! /bin/bash
#Shell script to automate pandaseq paired end assembly

for file in $(<SchlossSampleNames.txt)
do
    pandaseq -f MiSeq_SOP/${file}_L001_R1_001.fastq -r MiSeq_SOP/${file}_L001_R2_001.fastq -w pandaseq_merged_reads/${file}.fasta -g pandaseq_merged_reads/${file}.log -L 255 -t 0.90

done
