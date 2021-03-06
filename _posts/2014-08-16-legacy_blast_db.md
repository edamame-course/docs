---
layout: page
title: "BLAST databases 2:  Legacy edition"
date: 2014-08-16
comments: true
date: 2014-08-16 16:44:36
---
{% include JB/setup %}

<h3 id="tutorial-on-running-blast-locally">Tutorial on running blast locally</h3>
<h2 id="how-to-make-a-blast-database-by-formatting-a-local-file">How to make a blast database by formatting a local file</h2>
<h3 id="1-navigate-to-the-miseq_sop-directory-we-will-use-hmp-fasta-file-from-pat-s-dataset-to-make-a-local-database-the-input-has-to-be-a-fasta-file-">1.  Navigate to the MiSeq_SOP/ directory.  We will use HMP fasta file from Pat's dataset to make a local database.  The input has to be a fasta file.</h3>
<pre class="editor-colors lang-text"><div class="line"><span class="text plain"><span class="meta paragraph text"><span>formatdb&nbsp;-i&nbsp;HMP_MOCK.v35.fasta&nbsp;-n&nbsp;MyFavoriteDB.db&nbsp;-p&nbsp;F</span></span></span></div></pre><p>In the above command, the <code>-i</code> argument is the input file of sequences from which you want to make the database.  The <code>-n</code> argument is the name that you want to give the database.  The <code>-p</code> F argument signifies that this will be a nucleotide database (as opposed to, e.g., a protein db).</p>
<p>View the new files using <code>ls.</code></p>
<p>This command will output four files: a log file, and three .db files:</p>
<ul>
<li>a .nhr file</li>
<li>a .nin file</li>
<li>a .nsq file</li>
</ul>
<p>Together, all of these comprise the new database.</p>
<h3 id="2-make-a-new-file-of-a-sequence-to-blast-against-your-database-">2.  Make a new file of a sequence to BLAST against your database.</h3>
<p> We will use the first sequence in of our cdhit_rep_seqs.fasta.  This is our first representative sequence, from QIIME OTU 0.</p>
<pre class="editor-colors lang-text"><div class="line"><span class="text plain"><span class="meta paragraph text"><span>head&nbsp;-n2&nbsp;../cdhit_rep_seqs/cdhit_rep_seqs.fasta&nbsp;&gt;&nbsp;myfavseq.fasta</span></span></span></div></pre><p>We call the output file "myfavseq.fasta"</p>
<h3 id="3-blast-myfavseq-against-your-new-hmp-database">3.  BLAST myfavseq against your new HMP database</h3>
<pre class="editor-colors lang-text"><div class="line"><span class="text plain"><span class="meta paragraph text"><span>blastall&nbsp;-i&nbsp;myfavseq.fasta&nbsp;-d&nbsp;MyFavoriteDB.db&nbsp;-p&nbsp;blastn&nbsp;-o&nbsp;results.blast</span></span></span></div></pre><h3 id="4-inspect-the-results-file-using-less-">4.  Inspect the results file using less.</h3>
<pre class="editor-colors lang-text"><div class="line"><span class="text plain"><span class="meta paragraph text"><span>less&nbsp;results.blast</span></span></span></div></pre>

-----------------------------------------------
-----------------------------------------------
