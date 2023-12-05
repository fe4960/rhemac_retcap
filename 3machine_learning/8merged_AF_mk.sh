#!/bin/sh
#cat /storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_50000_*_new_maxAF10_mk | awk '{split($1,a,":"); print a[1]"\t"a[2]-1"\t"a[2]"\t"$_}' | sort -k 1n,1n -k 2n,2n > /storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_all_new_maxAF10_mk_bed

#bedtools intersect -wo -a /storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_all_new_maxAF10_mk_bed -b /storage/chenlab/Users/junwang/monkey/data/retcap/mac8_target_coor_uniq_rheMac8_rheMac10    > /storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_all_new_maxAF10_mk_bed_design

cat /storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF | awk '{split($1,a,":"); print a[1]"\t"a[2]-1"\t"a[2]"\t"$_}' | sort -k 1n,1n -k 2n,2n > /storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_bed

bedtools intersect -wo -a /storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_bed -b /storage/chenlab/Users/junwang/monkey/data/retcap/mac8_target_coor_uniq_rheMac8_rheMac10 > /storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_bed_design
