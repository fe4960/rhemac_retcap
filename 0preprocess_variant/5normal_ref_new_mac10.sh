#!/bin/sh
rhemac10_fa="/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_10/Macaca_mulatta.Mmul_10.dna.toplevel.fa"
hg19_fa="/storage/chen/home/jw29/general_tool/hg19.fa"
bcftools=bcftools
main="/storage/chenlab/Users/junwang/monkey/data/database"

for file1 in retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep_gatkfiltered.vcf.gz.splitMuliallele 

do
file=${main}/${file1}
$bcftools view -h ${file} | grep "CHR" > ${file}_header
file_hg19=${file}_hg19AF


awk '{if($1!~/fix/){split($1,a,":"); printf a[1]"\t"a[2]"\t"$2":"$3":"$5":"$6":"$4"\t"a[3]"\t"a[4]"\t";for(i=7;i<=NF;i++){printf $i"\t"FS}; printf "\n" }}' ${file_hg19} > ${file_hg19}_format


cat monkey/data/database/vcf_header ${file}_header ${file_hg19}_format > ${file_hg19}_w_header

#$bcftools norm -f ${hg19_fa} -c w -c s  ${file_hg19}_w_header > ${file_hg19}_w_header_norm_ref_corrected  2> ${file_hg19}_w_header_norm_ref_corrected_log
$bcftools norm -f ${hg19_fa} -c w  ${file_hg19}_w_header > ${file_hg19}_w_header_norm_ref  2> ${file_hg19}_w_header_norm_ref_log

done


