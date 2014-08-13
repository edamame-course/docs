7.  **Chimera checking**
We will use ChimeraSlayer to check for chimeras among the representative sequences.  ChimeraSlayer requries an alignment as input, and also a reference of aligned sequences.
```
identify_chimeric_seqs.py -m ChimeraSlayer -i pynast_aligned/cdhit_rep_seqs_aligned.fasta -a /macqiime/greengenes/core_set_aligned.fasta.imputed -o chimeric_seqs_cs.txt
```
*Hint*:  The documentation for identify_chimeric_seqs.py recommends that the same alignment reference, the `-a` option, should be used for ChimeraSlayer as was used for building the alignment. This alignment file is, by default with the `align_seqs.py` script, not needed to be user-specified; `align_seqs.py` knows where to find the alignment reference file, which is buried in the guts of the QIIME directories.  However, the `identify_chimeric_seqs.py` does not know where to look for the same alignment file. A good trick to know is that the 'print_qiime_config.py' script will provide the path to many of the common default files used by various QIIME scripts, including the alignment.

![img9](img/QIIMETutorial1_IMG/IMG_09.jpg)

**AshleyContinueHERE**
  ChimeraSlayer can take a long time.  You can let it run, or kill the command (Control C on Macs) because we have the next file ready for you [here](link to new directory) **InsertLinkoFile**.
Inspect the chimeric_seqs_cs.txt file.  We can use `wc` to find that XX sequences are identified as chimeras.  We will remove these (and the alignment failures) from the dataset.
```
wc -l chimeric_seqs_cs.txt
```
