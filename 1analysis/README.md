##### 0. Summarize sequencing coverage #####

python 0summarize_coverage.py

##### 1. Do MDS analysis of the genotype data using plink #####

sh 2pca.sh

##### 2. Add colony information of the MDS result #####

python 3add_colony.py

##### 3. Classify targeted genes in ASD and ND  #####

sh 4label_retnet_ND.sh

##### 4. Get dinucleotides surrounding the sequenced variants. #####

perl 5dinucleotide.pl

sh 5dinucleotide_bed.sh

##### 5. Count number of CG/GC in the targeted sequence #####

perl 5dinucleotide_design_bed.pl 

##### 6. Summarize variant type and collected the allele frequency of rhesus variants in rhesus macaques (this study) and humans (gnomAD) #####

python 6retnet_var_AF.py

##### 7. Annotate variants in hg19 with dbNSPF #####

sh 7search_dbNSPF.sh

##### 8. Format variants prediction scores collected from dbNSFP to variants #####

python 8organize_score_extend_all.py

##### 9. Identify likely benign and pathogenic variants based on HGMD and Clinvar #####

python 9filter_benign_pathogenic.py

##### 10. Plot the CADD score and hg19 Allele frequency of variants #####

R 10benign_variant_plot.R

##### 11. Annotate genes associated with pathogenic variants #####

python 11anno_gene_patho.py


