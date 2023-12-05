#!/bin/sh
dbNSFP="/storage/chen/Pipeline/pipeline/pipeline_restructure/bin/dbNSFP3.5a"
#invcf=$1
#vcf=${invcf}_format
#vcf=${invcf}
####awk -F "\t" 'BEGIN{FS=OFS="\t"}{$3= "." OFS $3}1' ${invcf} | awk -F "\t" '{print "chr"$_}'> $vcf
#java -Xmx5g -cp  ${dbNSFP}  search_dbNSFP35a -i ${invcf} -o ${invcf}.dbNSFP -s -w 1,9,3,4,7,243,26,32,35,38,42,49,52,62,65,59,55,78,108,110,114,119,70,71 -v hg19
#####java -Xmx5g -cp  ${dbNSFP}  search_dbNSFP35a -i ${vcf} -o ${vcf}.dbNSFP -s -w 1,2,3,4,24,30,33,36,40,50,53,58,60,63,70,72,80,107,109,111,113,115 -v hg19
#main_data_dir="/storage/chenlab/Users/junwang/monkey/data/database/"
main_data_dir="/storage/chenlab/Users/junwang/monkey/data/retcap/"

main=$main_data_dir
#file="variant_table_GVCFs.10_updated_corrected_vep101_updated_new_gnomad_clinvar_retnet"
#file="variant_table_retcap_corrected_vep101_updated_new_gnomad_clinvar_retnet"
#file="variant_table_retcap_corrected_vep101_target_updated_gnomad_clinvar_retnet"
#file="variant_table_retcap_new_corrected_vep101_target_updated_gnomad_clinvar_retnet"
#file="variant_table_retcap_new1_corrected_vep101_target_updated_gnomad_clinvar_retnet"
#file="variant_table_retcap_new1_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet"
#file="variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet"
file="target_gene_with_var_new2_rm8_swiss"

#less $main_data_dir/$1 |  awk '{ split($1,a,":"); print a[1]"\t"a[2]"\t.\t"a[3]"\t"a[4]"\t60\tPASS\t.\tGT:VR:RR:DP:GQ\t0/1:100:100:200:."}' > $main_data_dir/$1.vcf_format
#tail -n+2 $main_data_dir/${file} |  awk '{split($15,a,":"); print "chr"a[1]"\t"a[2]"\t.\t"a[3]"\t"a[4]"\t60\tPASS\t.\tGT:VR:RR:DP:GQ\t0/1:100:100:200:."}' > $main_data_dir/${file}.vcf_format

less $main_data_dir/${file}  | awk '{ print "chr"$1"\t"$2"\t"$3"\t"$4"\t"$5"\t60\tPASS\t"$8"\tGT:VR:RR:DP:GQ\t0/1:100:100:200:."}' > $main_data_dir/${file}.vcf_format

cat monkey/data/vcf_header $main_data_dir/${file}.vcf_format > $main_data_dir/${file}.wHeader.vcf


shellPath=/storage/chen/Pipeline/pipeline/pipeline_restructure
export PATH=${shellPath}/bin/jdk1.8.0_121/bin/:$PATH
fastpPath=${shellPath}/bin/fastp
bwaPath=${shellPath}/bin/bwa
samtoolsPath=${shellPath}/bin/samtools-1.2/samtools
gatkPath=${shellPath}/bin/gatk4/gatk
geneFile="ig"
compressedFormat="miseq"
cutoff=0.005
#monkey/data/OCA_gene.vcf_all_variant_LoF_AF_hg19AF_coor_head.vcf

#python ${shellPath}/bin/annotate_filter/dbNSFP_score.py -i $main_data_dir/${file}.wHeader.vcf  -o $main_data_dir/${file}.wHeader.dbNSFP  -t SNP -f 1.1 -c 1 -s 1 -p -d ${file}
/usr/bin/python2.7 ${shellPath}/bin/annotate_filter/pipeline_filter_and_annotate.dbNSFP_score_MutationAssessor.py -i $main/${file}.wHeader.vcf  -o $main/${file}.force_call.snp.anno.vcf -d ${file} -t SNP -f 1.1 -c 1 -s 1 -p


