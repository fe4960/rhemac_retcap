#!/bin/sh
main_dir=/storage/chenlab/Users/junwang/monkey/scripts/database/
main_data_dir=/storage/chenlab/Users/junwang/monkey/data/database
export LD_LIBRARY_PATH=/storage/chen/Software/lib/usr/lib64:$LD_LIBRARY_PATH

hg19_fa="/storage/chen/home/jw29/general_tool/hg19.fa"

bcftools="/storage/chen/home/jw29/software/bcftools-1.17/bcftools"

#for file in retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep
for file in retcap_genotypeGVCFs.3_output.filtered.snps.removed.vep retcap_genotypeGVCFs.3_output.filtered.indels.removed.vep

do

total_var=/storage/chenlab/Users/junwang/monkey/data/database/retcap_rhemac10_coor
rm ${total_var}



file_new=/storage/chenlab/Users/junwang/monkey/data/database/${file}_gatkfiltered.vcf.gz.splitMuliallele
grep -v -P "^#" ${file_new} |  awk '{ print "chr"$1"\t"$2-1"\t"$2"\tchr"$1":"$2"\t.\t+"}' >>  ${total_var}



sort -u ${total_var}  > ${total_var}_uniq


/storage/chen/Software/liftOver ${total_var}_uniq  /storage/chen/Pipeline/monkey_analysis/rheMac10ToHg19.over.chain.gz  ${total_var}_uniq_rheMac10_hg19 ${total_var}_uniq_rheMac10_hg19_unmap


perl $main_dir/4match_rheMac10_hg19_coor.pl  ${total_var}_uniq  ${total_var}_uniq_rheMac10_hg19    ${total_var}_uniq_rheMac10_hg19_unmap


#for file in retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep

#do

#file_new=${main_data_dir}/${file}_gatkfiltered.vcf.gz.splitMuliallele

perl $main_dir/5add_mac10_hg19_chain_str_noAF.pl  /storage/chenlab/Users/junwang/monkey/data/database/retcap_rhemac10_coor_uniq_hg19  ${file_new}

$bcftools view -h ${file_new} | grep -v "contig" > ${file_new}_header
file_hg19=${file_new}_hg19AF


#awk '{if($1!~/fix/){split($1,a,":"); printf a[1]"\t"a[2]"\t"$2":"$3":"$5":"$6":"$4"\t"a[3]"\t"a[4]"\t";for(i=7;i<=NF;i++){printf $i"\t"FS}; printf "\n" }}' ${file_hg19}  > ${file_hg19}_format
awk '{if($1!~/fix/){split($1,a,":"); printf a[1]"\t"a[2]"\t"$2":"$3":"$5":"$6":"$4"\t"a[3]"\t"a[4]"\t";for(i=7;i<=NF;i++){printf $i"\t"}; printf "\n" }}' ${file_hg19} | sort -k 1,1 -k 2n,2n  > ${file_hg19}_format


cat monkey/data/database/vcf_header ${file_new}_header ${file_hg19}_format > ${file_hg19}_w_header

#$bcftools norm -f ${hg19_fa} -c w -c s  ${file_hg19}_w_header > ${file_hg19}_w_header_norm_ref_corrected  2> ${file_hg19}_w_header_norm_ref_corrected_log

rm ${file_hg19}_w_header.gz

bgzip ${file_hg19}_w_header

tabix -p vcf ${file_hg19}_w_header.gz

$bcftools norm -f ${hg19_fa} -c w  ${file_hg19}_w_header.gz > ${file_hg19}_w_header_norm_ref  2> ${file_hg19}_w_header_norm_ref_log

done

