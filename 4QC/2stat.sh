#!/bin/sh

bcftools="/storage/chen/home/jw29/software/bcftools-1.17/bcftools"
 

#$bcftools stats -s -  /storage/chenlab/Users/junwang/monkey/data/database/retcap_genotypeGVCFs.3_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele.flt.GQ_DP_AB_new /storage/chenlab/Users/junwang/monkey/data/database/retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_norm_ref_corrected.flt.GQ_DP_AB_new /storage/chenlab/Users/junwang/monkey/data/database/forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_norm_ref_corrected.flt.GQ_DP_AB_new 
$bcftools stats -s -  /storage/chenlab/Users/junwang/monkey/data/database/retcap_genotypeGVCFs.3_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele.flt.GQ_DP_AB_new > /storage/chenlab/Users/junwang/monkey/data/database/retcap_genotypeGVCFs.3_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele.flt.GQ_DP_AB_new_stat

$bcftools stats -s - /storage/chenlab/Users/junwang/monkey/data/database/retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_norm_ref_corrected.flt.GQ_DP_AB_new > /storage/chenlab/Users/junwang/monkey/data/database/retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_norm_ref_corrected.flt.GQ_DP_AB_new_stat

$bcftools stats -s - /storage/chenlab/Users/junwang/monkey/data/database/forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_norm_ref_corrected.flt.GQ_DP_AB_new  > /storage/chenlab/Users/junwang/monkey/data/database/forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_norm_ref_corrected.flt.GQ_DP_AB_new_stat
