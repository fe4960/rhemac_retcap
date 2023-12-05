#!/bin/sh

bcftools="/storage/chen/home/jw29/software/bcftools-1.17/bcftools"

dir="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_snp_reprod_with"
out=${dir}/comp_sum
rm $out
#bgzip ${dir}/36348
#tabix -p vcf ${dir}/36348.gz
#bgzip ${dir}/34795_S242_L003
#tabix -p vcf ${dir}/34795_S242_L003.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36348-34795  ${dir}/36348.gz ${dir}/34795_S242_L003.gz

#for i in 36441	39055_S146_L002 36352	CNPRC_32964_S25_L001 36369	CNPRC_34752_S75_L004 36358	CNPRC_35016_S78_L004 36375	CNPRC_35074_S80_L002 36337	CNPRC_35224_S80_L004 36340	CNPRC_35308_S12_L003 36335	CNPRC_37464_S27_L003 36384	CNPRC_37971_S33_L003 36334	MK_36675_S75_L003 36322	MK_37396_S102_L003
#do
#bgzip ${dir}/${i}
#tabix -p vcf ${dir}/${i}.gz
#done

#for st in 36441-39055_S146_L002 36352-CNPRC_32964_S25_L001 36369-CNPRC_34752_S75_L004 36358-CNPRC_35016_S78_L004 36375-CNPRC_35074_S80_L002 36337-CNPRC_35224_S80_L004 36340-CNPRC_35308_S12_L003 36335-CNPRC_37464_S27_L003 36384-CNPRC_37971_S33_L003 36334-MK_36675_S75_L003 36322-MK_37396_S102_L003
for st in 36383B-36383C 36820_S125_L003-36820_S152_L002 38107_S145_L003-38107_S180_L002 38682_S156_L003-38682_S76_L001 41645_S146_L003-41645_S232_L003 41748_S157_L003-41748_S34_L001 42759_S166_L003-42759_S88_L001 43563_S167_L003-43563_S33_L001
do

IFS="-" read -ra array <<< "$st"

/storage/chen/home/jw29/software/bcftools-1.17/bcftools isec -n=2  -w1 -o ${dir}/$st  ${dir}/${array[0]}.gz ${dir}/${array[1]}.gz
count1=$(less ${dir}/${array[0]}.gz | grep -v "#" | wc -l )
count2=$(less ${dir}/${array[1]}.gz | grep -v "#" | wc -l )
count3=$(less ${dir}/$st | grep -v "#" | wc -l )
p1=$(echo "$count3 / $count1" | bc )
p2=$(echo "$count3 / $count2" | bc )
echo "$st $count1 $count2 $count3 ${p1} ${p2}" >> $out
done

#$bcftools isec -n=2  -w1 -o ${dir}/36352_32964  ${dir}/36352.gz ${dir}/CNPRC_32964_S25_L001.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36369_34752  ${dir}/36369.gz ${dir}/CNPRC_34752_S75_L004.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36358_35016  ${dir}/36358.gz ${dir}/CNPRC_35016_S78_L004.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36375_35074  ${dir}/36375.gz ${dir}/CNPRC_35074_S80_L002.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36337_35224  ${dir}/36337.gz ${dir}/CNPRC_35224_S80_L004.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36340_35308  ${dir}/36340.gz ${dir}/CNPRC_35308_S12_L003.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36335_37464  ${dir}/36335.gz ${dir}/CNPRC_37464_S27_L003.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36384_37971  ${dir}/36384.gz ${dir}/CNPRC_37971_S33_L003.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36334_36675  ${dir}/36334.gz ${dir}/MK_36675_S75_L003.gz
#$bcftools isec -n=2  -w1 -o ${dir}/36322_37396  ${dir}/37396.gz ${dir}/MK_37396_S102_L003.gz





