#!/bin/sh
main_dir=/storage/chenlab/Users/junwang/monkey/scripts/database/
main_data_dir=/storage/chenlab/Users/junwang/monkey/data/database
export LD_LIBRARY_PATH=/storage/chen/Software/lib/usr/lib64:$LD_LIBRARY_PATH

#file="monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar"

total_var=/storage/chenlab/Users/junwang/monkey/data/retcap/clinv_hg19_coor
rm ${total_var}

#for file in genotypeGVCFs.7_onTarget_output.filtered.indels.removed.vep.sorted  genotypeGVCFs.7_onTarget_output.filtered.snps.removed.vep
#for file in genotypeGVCFs.8_output.filtered.snps.removed.vep  genotypeGVCFs.8_output.filtered.indels.removed.vep.sorted
#for file in genotypeGVCFs.9_output.filtered.snps.removed.vep  genotypeGVCFs.9_output.filtered.indels.removed.vep.sorted.fix
for file in target_gene_with_var_new2_rm8_clinvar
do
file_new=/storage/chenlab/Users/junwang/monkey/data/retcap/${file}
grep -v -P "^#" ${file_new} |  awk '{ print "chr"$1"\t"$2-1"\t"$2"\tchr"$1":"$2"\t.\t+"}' >>  ${total_var}

done


sort -u ${total_var}  > ${total_var}_uniq


/storage/chen/Software/liftOver ${total_var}_uniq  /storage/chen/Pipeline/monkey_analysis/hg19ToRheMac10.over.chain.gz  ${total_var}_uniq_hg19_rheMac10 ${total_var}_uniq_hg19_rheMac10_unmap


perl $main_dir/4match_rheMac10_hg19_coor.pl  ${total_var}_uniq  ${total_var}_uniq_hg19_rheMac10    ${total_var}_uniq_hg19_rheMac10_unmap


#for file in  genotypeGVCFs.7_onTarget_output.filtered.indels.removed.vep.sorted  genotypeGVCFs.7_onTarget_output.filtered.snps.removed.vep 
#for file in genotypeGVCFs.8_output.filtered.snps.removed.vep  genotypeGVCFs.8_output.filtered.indels.removed.vep.sorted
#for file in genotypeGVCFs.9_output.filtered.snps.removed.vep  genotypeGVCFs.9_output.filtered.indels.removed.vep.sorted.fix

for file in target_gene_with_var_new2_rm8_clinvar

do
file_new=/storage/chenlab/Users/junwang/monkey/data/retcap/${file}

perl $main_dir/5add_mac10_hg19_chain_str_noAF.pl  /storage/chenlab/Users/junwang/monkey/data/retcap/clinv_hg19_coor_uniq_hg19  ${file_new}

done

