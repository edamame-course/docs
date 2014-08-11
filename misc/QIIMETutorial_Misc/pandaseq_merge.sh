#! /bin/bash
#Shell script to automate pandaseq paired end assembly

#Type this into the terminal before beginning the script
#ls MiSeq_SOP/ >list.txt

#pull out the first unique 9 characters
#W0rk on this
#grep R1 list.txt >R1_list.txt

#change permissions
#chmod +x panseq_merge.sh

for file in $(<SchlossSampleNames.txt)
do
    pandaseq -f MiSeq_SOP/${file}_L001_R1_001.fastq -r MiSeq_SOP/${file}_L001_R2_001.fastq -w pandaseq_merged_reads/${file}.fasta -g pandaseq_merged_reads/${file}.log -L 255 -t 0.90

done

#chmod 777 panseq_merge.sh
