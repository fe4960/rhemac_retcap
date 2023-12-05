#!/bin/sh
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
python=/storage/chen/Software/miniconda2/bin/python
main="monkey/data/database"
echo "==== `date` prepare format for WES pipeline========="

file="monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar"
file1="target_gene_with_var_new2_rm8_clinvar"
#less ${main}/${1}_hg19AF_w_header_norm_ref |  awk '{ print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t60\tPASS\t.\tGT:VR:RR:DP:GQ\t0/1:100:100:200:."}' >  ${main}/${1}_hg19AF_w_header_norm_ref_coor

less $file | awk '{ print "chr"$1"\t"$2"\t"$3"\t"$4"\t"$5"\t60\tPASS\t"$8"\tGT:VR:RR:DP:GQ\t0/1:100:100:200:."}' >  ${file}_coor


cat /storage/chen/home/jw29/monkey/data/vcf_header ${file}_coor > ${file}_coor_header.vcf


#   $python ${shellPath}/bin/annotate_filter/pipeline_filter_and_annotate.py -i ${main}/${1}_hg19AF_coor_header.vcf  -o ${main}/${1}.force_call.snp.anno.vcf -d $1 -t SNP -f 1.1 -c 1 -s 1 -p

#    $python ${shellPath}/bin/annotate_filter/convert_to_readable_form.py -s ${main}/${1}.force_call.snp.anno.vcf -i ${main}/${1}.force_call.snp.anno.vcf  -o ${main}/${1}.format.sorted.analysis

   $python ${shellPath}/bin/annotate_filter/pipeline_filter_and_annotate.py -i ${file}_coor_header.vcf  -o ${file}.force_call.snp.anno.vcf -d ${file1} -t SNP -f 1.1 -c 1 -s 1 -p

   $python ${shellPath}/bin/annotate_filter/convert_to_readable_form.py -s ${file}.force_call.snp.anno.vcf -i ${file}.force_call.snp.anno.vcf  -o ${file}.format.sorted.analysis
