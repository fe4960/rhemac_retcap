#!/bin/sh
shellPath=/storage/chen/Pipeline/pipeline/pipeline_restructure
export PATH=${shellPath}/bin/jdk1.8.0_121/bin/:$PATH
fastpPath=${shellPath}/bin/fastp
bwaPath=${shellPath}/bin/bwa
samtoolsPath=${shellPath}/bin/samtools-1.2/samtools
gatkPath=${shellPath}/bin/gatk4/gatk

#for file in forDistribution_1-2UC_ucdavis.1-2.retinal.snps forDistribution_1-2UC_ucdavis.1-2.retinal.indels genotypeGVCFs.7_onTarget_output.filtered.snps.removed.vep  genotypeGVCFs.7_onTarget_output.filtered.indels.removed.vep.sorted  retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget
for file in retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep 
do
new_file="monkey/data/database/${file}"
${gatkPath} --java-options "-Xmx4g" VariantFiltration  -V ${new_file}.vcf.gz -filter "QD < 5.0" --filter-name "QD5" -filter "QUAL < 30.0" --filter-name "QUAL30" -filter "FS > 15.0" --filter-name "FS15" -filter "MQ < 50.0" --filter-name "MQ50" -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" -O ${new_file}_gatkfiltered.vcf.gz

done
