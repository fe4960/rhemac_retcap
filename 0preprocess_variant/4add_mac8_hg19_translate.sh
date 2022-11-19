#!/bin/sh
export LD_LIBRARY_PATH=/storage/chen/Software/lib/usr/lib64:$LD_LIBRARY_PATH

main_dir=/storage/chenlab/Users/junwang/monkey/scripts/database/
main_data_dir=/storage/chenlab/Users/junwang/monkey/data/database

total_var=/storage/chenlab/Users/junwang/monkey/data/database/capture_rhemac8_coor
rm ${total_var}

for file in forDistribution_1-2UC_ucdavis.1-2.retinal.snps forDistribution_1-2UC_ucdavis.1-2.retinal.indels  retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1

do
file_new=/storage/chenlab/Users/junwang/monkey/data/database/${file}_gatkfiltered.vcf.gz.splitMuliallele
grep -v -P "^#" ${file_new} |  awk '{ print $1"\t"$2-1"\t"$2"\t"$1":"$2"\t.\t+"}' >>  ${total_var}
done

sort -u ${total_var}  > ${total_var}_uniq


/storage/chen/Software/liftOver ${total_var}_uniq  /storage/chenlab/Users/junwang/monkey/data/database/rheMac8ToRheMac10.over.chain.gz  ${total_var}_uniq_rheMac8_rheMac10 ${total_var}_uniq_rheMac8_rheMac10_unmap


perl $main_dir/4match_rheMac8_rheMac10_coor.pl  ${total_var}_uniq  ${total_var}_uniq_rheMac8_rheMac10    ${total_var}_uniq_rheMac8_rheMac10_unmap


for file in  retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1 forDistribution_1-2UC_ucdavis.1-2.retinal.snps forDistribution_1-2UC_ucdavis.1-2.retinal.indels 
do
file_new=${main_data_dir}/${file}_gatkfiltered.vcf.gz.splitMuliallele

perl $main_dir/5add_mac8_mac10_chain_str.pl   $main_data_dir/capture_rhemac8_coor_uniq_rheMac10    ${file_new}
done


total_var=/storage/chenlab/Users/junwang/monkey/data/database/capture_rhemac8_coor_rhemac10
rm ${total_var}

for file in forDistribution_1-2UC_ucdavis.1-2.retinal.snps forDistribution_1-2UC_ucdavis.1-2.retinal.indels  retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1

do
file_new=/storage/chenlab/Users/junwang/monkey/data/database/${file}_gatkfiltered.vcf.gz.splitMuliallele_rheMac10
grep -v -P "^#" ${file_new} |  awk '{ print "chr"$1"\t"$2-1"\t"$2"\tchr"$1":"$2"\t.\t+\t"}' >>  ${total_var}

done


sort -u ${total_var}  > ${total_var}_uniq


/storage/chen/Software/liftOver ${total_var}_uniq  /storage/chen/Pipeline/monkey_analysis/rheMac10ToHg19.over.chain.gz  ${total_var}_uniq_rheMac8_rheMac10_hg19 ${total_var}_uniq_rheMac8_rheMac10_hg19_unmap


perl $main_dir/4match_rheMac10_hg19_coor.pl  ${total_var}_uniq  ${total_var}_uniq_rheMac8_rheMac10_hg19    ${total_var}_uniq_rheMac8_rheMac10_hg19_unmap


for file in  retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1 forDistribution_1-2UC_ucdavis.1-2.retinal.snps forDistribution_1-2UC_ucdavis.1-2.retinal.indels 
do
file_new=${main_data_dir}/${file}_gatkfiltered.vcf.gz.splitMuliallele

perl $main_dir/5add_mac10_hg19_chain_str_noAF.pl  /storage/chenlab/Users/junwang/monkey/data/database/capture_rhemac8_coor_rhemac10_uniq_hg19  ${file_new}_rheMac10

done

