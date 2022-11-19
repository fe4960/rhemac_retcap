#!/usr/bin
main="/storage/chen/Software/plink_linux_x86_64"
main1="/storage/chen/home/jw29"


#for i in "${arr[@]}"
	
#	do
#i="monkey/data/target_gene_final.vcf_all_variant_HGMD_uniq_missense_snp"
#i="monkey/data/target_gene_final.vcf_all_variant_HGMD_target_uniq_missense_snp_common"
#i="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.1"
#i="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.01"
#i="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.005"
#i="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF_AC2"
#i="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2"
#i="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2_new1"
i="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2_new2_rm8"

hapmap="${i}.map"
ped="${i}.ped"

#	$main/plink -bfile /storage/chen/fgi4/Glaucoma_GWAS/00_trainingGWAS/hapmap_pca/hapmap_ucsc_19 --extract $rs_file --make-bed --out $out
#	$main/plink -bfile /storage/chen/data_share_folder/GWAS_references/hapmap-ref/hapmap_ucsc_19 --extract $rs_file --make-bed --out $out


#	$main/plink --bfile  $out  --merge  $ped $hapmap  --make-bed --out $merge  --allow-no-sex
        $main/plink --file $i --make-bed --out $i
	$main/plink --bfile  $i --genome --out $i

	$main/plink --bfile  $i --read-genome  $i.genome  --cluster --mds-plot 4 --out $i
	
	$main/plink --bfile  $i --recode-vcf --out $i


	
 #      done



