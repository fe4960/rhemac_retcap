#!/bin/sh
rhemac10_fa="/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_10/Macaca_mulatta.Mmul_10.dna.toplevel.fa"
hg19_fa="general_tool/hg19.fa"
bcftools=bcftools
main="/storage/chenlab/Users/junwang/monkey/data/database"
for file1 in forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele   retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele   retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele
do
file=${main}/${file1}
$bcftools view -h ${file} | grep "CHR" > ${file}_header

file_rhemac10=${file}_rheMac10
cat monkey/data/database/vcf_header ${file}_header ${file_rhemac10} > ${file_rhemac10}_w_header

#$bcftools norm -f ${rhemac10_fa} -c w -c s  ${file_rhemac10}_w_header > ${file_rhemac10}_w_header_norm_ref_corrected  2> ${file_rhemac10}_w_header_norm_ref_corrected_log
$bcftools norm -f ${rhemac10_fa} -c w  ${file_rhemac10}_w_header > ${file_rhemac10}_w_header_norm_ref  2> ${file_rhemac10}_w_header_norm_ref_log

file_hg19=${file}_rheMac10_hg19AF


awk '{split($1,a,":"); printf a[1]"\t"a[2]"\t"$4"|"$2":"$3":"$5":"$6":\t"a[3]"\t"a[4]"\t";for(i=7;i<=NF;i++){printf $i"\t"FS}; printf "\n" }' ${file_hg19} | grep -v "chr1_jh636052_fix" > ${file_hg19}_format

cat monkey/data/database/vcf_header ${file}_header ${file_hg19}_format > ${file_hg19}_w_header


#$bcftools norm -f ${hg19_fa} -c w -c s  ${file_hg19}_w_header > ${file_hg19}_w_header_norm_ref_corrected  2> ${file_hg19}_w_header_norm_ref_corrected_log
$bcftools norm -f ${hg19_fa} -c w  ${file_hg19}_w_header > ${file_hg19}_w_header_norm_ref  2> ${file_hg19}_w_header_norm_ref_log

done


