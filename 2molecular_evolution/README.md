##### 1.Select primary transcripts from human and rhesus macaque genomes #####

python 1select_primary_trans.py

##### 2.Perform codon-aware alignment #####

python 2sequence_alignment.py

##### 3.Run codeml to compute Dn/Ds #####

perl 3run_codeml.pl

##### 4.Extract Pn, Ps, Dn, Ds ##### 

python 4prepare_NI.py

##### 5.Compute neutral index #####

R 5compute_NI.R

##### 6.plot box plot for Dn/Ds and NI #####

R 6boxplot.R
