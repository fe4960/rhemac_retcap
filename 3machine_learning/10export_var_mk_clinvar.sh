#!/bin/sh
#file=monkey/data/database/variant_table_rhemac10_var_GVCFs.9
#file0=/storage/chenlab/Users/junwang/monkey/data/database/variant_table_GVCFs.10_retcap2_updated_AF
#file=/storage/chenlab/Users/junwang/monkey/data/database/variant_table_GVCFs.10_retcap2_updated_AF_var
#file0=/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_all_new_maxAF10_mk_bed_design
file0=/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_bed_design

file=/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_mk_design.vcf
echo "#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	INDI" > ${file}
#tail -n+2 monkey/data/database/variant_table | cut -f 2 | awk -F ":" '{print $1"\t"$2"\t.\t"$3"\t"$4"\t.\tPASS\t.\tGT:AD:DP:GQ\t0/1:0,100:100:200"}' |sort -k 1,1 -k 2n,2n -k 3n,3n >> ${file}
cut -f 4 $file0 | awk -F ":" '{print $1"\t"$2"\t.\t"$3"\t"$4"\t.\tPASS\t.\tGT:AD:DP:GQ\t0/1:0,100:100:200"}' |sort -k 1,1 -k 2n,2n -k 3n,3n >> ${file}
#tail -n+2 monkey/data/database/variant_table_GVCFs.9 | cut -f 2 | awk -F ":" '{print $1"\t"$2"\t.\t"$3"\t"$4"\t.\tPASS\t.\tGT:AD:DP:GQ\t0/1:0,100:100:200"}' |sort -k 1,1 -k 2n,2n -k 3n,3n >> ${file}
