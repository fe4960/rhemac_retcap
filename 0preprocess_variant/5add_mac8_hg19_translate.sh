#!/bin/sh
export LD_LIBRARY_PATH=/storage/chen/Software/lib/usr/lib64:$LD_LIBRARY_PATH

main_dir=/storage/chenlab/Users/junwang/monkey/scripts/database/
main_data_dir=/storage/chenlab/Users/junwang/monkey/data/database

rhemac10_fa="/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_10/Macaca_mulatta.Mmul_10.dna.toplevel.fa"
hg19_fa="/storage/chen/home/jw29/general_tool/hg19.fa"

bcftools="/storage/chen/home/jw29/software/bcftools-1.17/bcftools" 

for file in forDistribution_1-2UC_ucdavis.1-2.retinal.snps forDistribution_1-2UC_ucdavis.1-2.retinal.indels  retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1

do

total_var=/storage/chenlab/Users/junwang/monkey/data/database/capture_rhemac8_coor
rm ${total_var}


file_new0=/storage/chenlab/Users/junwang/monkey/data/database/${file}_gatkfiltered.vcf.gz.splitMuliallele

$bcftools view -h ${file_new0} | grep -v "contig" > ${file_new0}_header
#exit
grep -v -P "^#" ${file_new0} |  awk '{ print $1"\t"$2-1"\t"$2"\t"$1":"$2"\t.\t+"}' >>  ${total_var}
#done

sort -u ${total_var}  > ${total_var}_uniq


/storage/chen/Software/liftOver ${total_var}_uniq  /storage/chenlab/Users/junwang/monkey/data/database/rheMac8ToRheMac10.over.chain.gz  ${total_var}_uniq_rheMac8_rheMac10 ${total_var}_uniq_rheMac8_rheMac10_unmap


perl $main_dir/4match_rheMac8_rheMac10_coor.pl  ${total_var}_uniq  ${total_var}_uniq_rheMac8_rheMac10    ${total_var}_uniq_rheMac8_rheMac10_unmap


file_new=${main_data_dir}/${file}_gatkfiltered.vcf.gz.splitMuliallele

perl $main_dir/5add_mac8_mac10_chain_str.pl   $main_data_dir/capture_rhemac8_coor_uniq_rheMac10    ${file_new}

file_rhemac10=${file_new}_rheMac10

sort -u  ${file_rhemac10} | sort -k 1,1 -k 2n,2n > ${file_rhemac10}_format

cat monkey/data/database/vcf_header  ${file_new0}_header   ${file_rhemac10}_format > ${file_rhemac10}_w_header

rm ${file_rhemac10}_w_header.gz
bgzip ${file_rhemac10}_w_header
tabix -p vcf ${file_rhemac10}_w_header.gz

$bcftools norm -f ${rhemac10_fa} -c w -c s ${file_rhemac10}_w_header.gz > ${file_rhemac10}_norm_ref_corrected  2> ${file_rhemac10}_norm_ref_log


total_var=/storage/chenlab/Users/junwang/monkey/data/database/capture_rhemac8_coor_rhemac10
rm ${total_var}


file_new=${file_rhemac10}_norm_ref_corrected
grep -v -P "^#" ${file_new} |  awk '{ print "chr"$1"\t"$2-1"\t"$2"\tchr"$1":"$2"\t.\t+\t"}' >>  ${total_var}


sort -u ${total_var}  > ${total_var}_uniq


/storage/chen/Software/liftOver ${total_var}_uniq  /storage/chen/Pipeline/monkey_analysis/rheMac10ToHg19.over.chain.gz  ${total_var}_uniq_rheMac8_rheMac10_hg19 ${total_var}_uniq_rheMac8_rheMac10_hg19_unmap


perl $main_dir/4match_rheMac10_hg19_coor.pl  ${total_var}_uniq  ${total_var}_uniq_rheMac8_rheMac10_hg19    ${total_var}_uniq_rheMac8_rheMac10_hg19_unmap



perl $main_dir/5add_mac10_hg19_chain_str_noAF.pl  /storage/chenlab/Users/junwang/monkey/data/database/capture_rhemac8_coor_rhemac10_uniq_hg19  ${file_new}


file_hg19=${file_new}_hg19AF


####awk '{split($1,a,":"); printf a[1]"\t"a[2]"\t"$4"|"$2":"$3":"$5":"$6":\t"a[3]"\t"a[4]"\t";for(i=7;i<=NF;i++){printf $i"\t"}; printf "\n" }' ${file_hg19} | grep -v "chr1_jh636052_fix" | sort -k 1,1 -k 2n,2n > ${file_hg19}_format


awk '{split($1,a,":"); printf a[1]"\t"a[2]"\t"$2":"$3":"$5":"$6"|"$4"\t"a[3]"\t"a[4]"\t";for(i=7;i<=NF;i++){printf $i"\t"}; printf "\n" }' ${file_hg19} | grep -v "chr1_jh636052_fix" | sort -k 1,1 -k 2n,2n > ${file_hg19}_format



cat monkey/data/database/vcf_header ${file_new0}_header  ${file_hg19}_format > ${file_hg19}_w_header

rm ${file_hg19}_w_header.gz 

bgzip ${file_hg19}_w_header

tabix -p vcf ${file_hg19}_w_header.gz

$bcftools norm -f ${hg19_fa} -c w  ${file_hg19}_w_header.gz > ${file_hg19}_w_header_norm_ref  2> ${file_hg19}_w_header_norm_ref_log

done

