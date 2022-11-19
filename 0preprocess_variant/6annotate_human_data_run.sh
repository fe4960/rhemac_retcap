#!/bin/sh
nohup sh monkey/scripts/database/7annotate_human_data_new.sh retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele_rheMac10 > monkey/scripts/database/7annotate_human_data_cap1_indels_noref.out 2> monkey/scripts/database/7annotate_human_data_cap1_indels_noref.err & 


nohup sh monkey/scripts/database/7annotate_human_data_new.sh retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10 > monkey/scripts/database/7annotate_human_data_cap1_snps_noref.out 2> monkey/scripts/database/7annotate_human_data_cap1_snps_noref.err & 

nohup sh monkey/scripts/database/7annotate_human_data_new.sh forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10 > monkey/scripts/database/7annotate_human_data_cap2_snps_noref.out 2> monkey/scripts/database/7annotate_human_data_cap2_snps_noref.err & 

nohup sh monkey/scripts/database/7annotate_human_data_new.sh forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele_rheMac10 > monkey/scripts/database/7annotate_human_data_cap2_indels_noref.out 2> monkey/scripts/database/7annotate_human_data_cap2_indels_noref.err & 


###########
 sbatch --mem=50000MB --output=monkey/scripts/database/7annotate_human_data_wes_indels_noref.out --error=monkey/scripts/database/7annotate_human_data_wes_indels_noref.err monkey/scripts/database/7annotate_human_data_new.sh genotypeGVCFs.10_output.filtered.indels.removed.vep.no.isoseq.sorted.fix_gatkfiltered.vcf.gz.splitMuliallele


sbatch --mem=50000MB --output=monkey/scripts/database/7annotate_human_data_wes_snps_noref.out --error=monkey/scripts/database/7annotate_human_data_wes_snps_noref.err monkey/scripts/database/7annotate_human_data_new.sh genotypeGVCFs.10_output.filtered.snps.removed.vep.no.isoseq_gatkfiltered.vcf.gz.splitMuliallele

sbatch -p short --mem=10000MB --output=monkey/scripts/database/7annotate_human_data_wes_snps_noref_cap2.out --error=monkey/scripts/database/7annotate_human_data_wes_snps_noref_cap2.err monkey/scripts/database/7annotate_human_data_new.sh retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele 

sbatch -p short --mem=10000MB --output=monkey/scripts/database/7annotate_human_data_wes_indels_noref_cap2.out --error=monkey/scripts/database/7annotate_human_data_wes_indels_noref_cap2.err monkey/scripts/database/7annotate_human_data_new.sh retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep_gatkfiltered.vcf.gz.splitMuliallele 




