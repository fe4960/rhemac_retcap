#!/bin/sh
#file=monkey/data/database/variant_table_rhemac10_var_GVCFs.9
file0=/storage/chenlab/Users/junwang/monkey/data/database/variant_table_GVCFs.10_retcap2_updated_AF
file=/storage/chenlab/Users/junwang/monkey/data/database/variant_table_GVCFs.10_retcap2_updated_AF_var

echo "#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	INDI" > ${file}
#tail -n+2 monkey/data/database/variant_table | cut -f 2 | awk -F ":" '{print $1"\t"$2"\t.\t"$3"\t"$4"\t.\tPASS\t.\tGT:AD:DP:GQ\t0/1:0,100:100:200"}' |sort -k 1,1 -k 2n,2n -k 3n,3n >> ${file}
tail -n+2 ${file0} | cut -f 2 | awk -F ":" '{print $1"\t"$2"\t.\t"$3"\t"$4"\t.\tPASS\t.\tGT:AD:DP:GQ\t0/1:0,100:100:200"}' |sort -k 1,1 -k 2n,2n -k 3n,3n >> ${file}
#tail -n+2 monkey/data/database/variant_table_GVCFs.9 | cut -f 2 | awk -F ":" '{print $1"\t"$2"\t.\t"$3"\t"$4"\t.\tPASS\t.\tGT:AD:DP:GQ\t0/1:0,100:100:200"}' |sort -k 1,1 -k 2n,2n -k 3n,3n >> ${file}
