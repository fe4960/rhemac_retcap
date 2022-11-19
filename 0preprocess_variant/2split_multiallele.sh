#!/bin/sh
#for file in forDistribution_1-2UC_ucdavis.1-2.retinal.snps.vcf.gz forDistribution_1-2UC_ucdavis.1-2.retinal.indels.vcf.gz  retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget.vcf.gz retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget.vcf.gz
######for file in forDistribution_1-2UC_ucdavis.1-2.retinal.snps forDistribution_1-2UC_ucdavis.1-2.retinal.indels  retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget
#for file in retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1
#do
#input=monkey/data/database/${file}_gatkfiltered.vcf.gz
#ref=/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_8.0.1/Mmul_8.0.1.fa
#/storage/chen/Software/bcftools/bcftools norm -m -both -f ${ref}  ${input} > ${input}.splitMuliallele
#done 

main=/storage/chenlab/Users/junwang/
for file in retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep 

do
input=${main}/monkey/data/database/${file}_gatkfiltered.vcf.gz
ref=/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_10/Macaca_mulatta.Mmul_10.dna.toplevel.fa
/storage/chen/Software/bcftools/bcftools norm -m -both -f ${ref}  ${input} > ${input}.splitMuliallele
done 

