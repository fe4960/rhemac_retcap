##### 0. Summarize sequencing coverage #####

0summarize_coverage.py

##### 1. Do MDS analysis of the genotype data using plink #####

2pca.sh

##### 2. Add colony information of the MDS result #####

3add_colony.py

##### 3. Classify targeted genes in ASD and ND  #####

4label_retnet_ND.sh

##### 4. Get dinucleotides surrounding the sequenced variants. #####

5dinucleotide.pl

5dinucleotide_bed.sh

##### 5. Count number of CG/GC in the targeted sequence #####

5dinucleotide_design_bed.pl 

##### 6. Summarize variant type and collected the allele frequency of rhesus variants in rhesus macaques (this study) and humans (gnomAD) #####

6retnet_var_AF.py

##### 7. Annotate variants in hg19 with dbNSPF #####

7search_dbNSPF.sh

##### 8. Format variants prediction scores collected from dbNSFP to variants #####

8organize_score_extend_all.py

##### 9. Identify likely benign and pathogenic variants based on HGMD and Clinvar #####

9filter_benign_pathogenic.py

##### 10. Plot the CADD score and hg19 Allele frequency of variants #####

10benign_variant_plot.R

##### 11. Annotate genes associated with pathogenic variants #####

11anno_gene_patho.py


