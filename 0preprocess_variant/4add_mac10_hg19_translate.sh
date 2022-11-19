#!/bin/sh
main_dir=/storage/chenlab/Users/junwang/monkey/scripts/database/
main_data_dir=/storage/chenlab/Users/junwang/monkey/data/database
export LD_LIBRARY_PATH=/storage/chen/Software/lib/usr/lib64:$LD_LIBRARY_PATH

total_var=/storage/chenlab/Users/junwang/monkey/data/database/retcap_rhemac10_coor
rm ${total_var}

for file in retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep

do
file_new=/storage/chenlab/Users/junwang/monkey/data/database/${file}_gatkfiltered.vcf.gz.splitMuliallele
grep -v -P "^#" ${file_new} |  awk '{ print "chr"$1"\t"$2-1"\t"$2"\tchr"$1":"$2"\t.\t+"}' >>  ${total_var}

done


sort -u ${total_var}  > ${total_var}_uniq


/storage/chen/Software/liftOver ${total_var}_uniq  /storage/chen/Pipeline/monkey_analysis/rheMac10ToHg19.over.chain.gz  ${total_var}_uniq_rheMac10_hg19 ${total_var}_uniq_rheMac10_hg19_unmap


perl $main_dir/4match_rheMac10_hg19_coor.pl  ${total_var}_uniq  ${total_var}_uniq_rheMac10_hg19    ${total_var}_uniq_rheMac10_hg19_unmap


for file in retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep

do

file_new=${main_data_dir}/${file}_gatkfiltered.vcf.gz.splitMuliallele

perl $main_dir/5add_mac10_hg19_chain_str_noAF.pl  /storage/chenlab/Users/junwang/monkey/data/database/retcap_rhemac10_coor_uniq_hg19  ${file_new}

done

