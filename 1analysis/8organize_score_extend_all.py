# less /storage/chenlab/Users/junwang/monkey/data/database/variant_table_GVCFs.10_updated_corrected_vep101_updated_new_gnomad_clinvar_retnet.dbNSFP | cut -f 1,3,4,5,6,8,11,17 | head -n 1
#chr	hg19_pos(1-based)	ref	alt	SIFT_score	Polyphen2_HVAR_score	MutationAssessor_score	REVEL_score
import subprocess
import re
#dbNSFP="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_updated_new_gnomad_clinvar_retnet.dbNSFP"
#dbNSFP="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_target_updated_gnomad_clinvar_retnet.dbNSFP"
dbNSFP="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet.dbNSFP"

dbNSFP_score={}
db=open(dbNSFP,"r") 
next(db)
for line in db:
	info=line.split()
	var=f'{info[0]}:{info[2]}:{info[3]}:{info[4]}'
	sift=info[5].split(";")
	polyphen2 = info[7].split(";")
	ma = info[10].split(";")
	mt = info[9].split(";")
	fa = info[11].split(";")
	proven=info[12].split(";")
	vest = info[13].split(";")
	dbNSFP_score[var]=f'{sift[0]}\t{polyphen2[0]}\t{ma[0]}\t{info[14]}\t{info[15]}\t{info[20]}\t{info[21]}\t{info[22]}\t{info[23]}\t{info[8]}\t{mt[0]}\t{fa[0]}\t{proven[0]}\t{vest[0]}\t{info[17]}\t{info[18]}\t{info[19]}';
db.close()

AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8_clean"

#AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap"
rhemac_AF={}
with open(AF_file,'r') as af:
	next(af)
	for line in af:
		info=line.split()
		info1=info[0].split(':')
		chrom=info1[0]
		start=info1[1]
		ref=info1[2]
		alt=info1[3]	
		rhemac_AF[f'{chrom}:{start}:{ref}:{alt}']=f'{info[-7]}\t{info[-2]}\t{info[-1]}'
	

#file="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_updated_new_gnomad_clinvar_retnet"
#file="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_target_updated_gnomad_clinvar_retnet"
file="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen"
#file="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet"

score_output=f'{file}_simple_score_extend_all'
score=open(score_output,"w")
score.write("rhemac_coor\thg19_coor\tclinvar\trhemac_var\thg_var\trhemac_AN\trhemac_hom_gf\trhemac_AF\tgnomad_AF\trevel\tcadd\tsift\tpolyphen2\tmutationAssessor\tMetaSVM_score\tMetaLR_score\tphyloP100way_vertebrate\tphyloP20way_mammalian\tphastCons100way_vertebrate\tphastCons20way_mammalian\tLRT\tMutationTaster\tFATHMM\tPROVEAN\tVEST3\tMutPred\tDANN\tGERP\tHGMD\n")
with open(file,"r") as f:
	next(f)
	for line1 in f:
#4       13:35340559:C:T 13      35340559        C       T       ALMS1   ENSMMUG00000002819      ENSMMUT00000003995      missense_variant        MODERATE        exon:5/23       ENSMMUT00000003995:1162_Gaa/Aaa ENSMMUT00000003995:388_E/K      2:73651940:G:A  2       73651940        G       A       exonic  ALMS1   .       synonymous_SNV  ALMS1:NM_015120:exon5:c.A1147A:p.K383K  .       .       .       .       .       .       .       .       .       PASS,hg19_reference_mismatch    0       0       0       None
		line2 = line1.rstrip()
		info=line2.split()
		if info[14] != "." :
			hg_coor=info[14].split(":")
#			match = re.search("MATCH-",info[24])
			gnomAD_AF=info[-4]
			revel_tmp="/storage/chenlab/Users/junwang/monkey/data/retnet_revel.tmp"
			revel_score = "."
			revel_tabix="/storage/chen/home/jw29/RPE65/data/revel_all_chromosomes_out.gz"
			#print(info[14])
			with open(revel_tmp,'w') as revel:
				subprocess.run([f'tabix {revel_tabix} {hg_coor[0]}:{hg_coor[1]}-{hg_coor[1]}'],shell=True,stdout=revel)
				tmp=open(revel_tmp,'r')	
				for revel_line in tmp:
			#1       35142   .       G       A       T       M       0.027
					revel_info=revel_line.rstrip().split()
					if revel_info[0] == hg_coor[0] and revel_info[1] == hg_coor[1] and revel_info[3] == hg_coor[2] and revel_info[4] == hg_coor[3]:
						revel_score=revel_info[-1]
				tmp.close()

			cadd_score = "."
#			cadd_tabix = "/storage/chenlab/Users/junwang/monkey/data/retcap/GRCh37-v1.6_simple_new_new1.gz"	
#			cadd_tabix = "/storage/chenlab/Users/junwang/monkey/data/retcap/GRCh37-v1.6_simple_new_new2.gz" 
#			cadd_tabix = "/storage/chenlab/Users/junwang/monkey/data/retcap/GRCh37-v1.6_retcap2_new.tsv.gz" ####for screen
#			cadd_tabix = "/storage/chenlab/Users/junwang/monkey/data/retcap/CADD/GRCh37-v1.6_simple_new.gz" 
			cadd_tabix = "/storage/chenlab/Users/junwang/monkey/data/retcap/CADD/GRCh37-v1.6_3fcba1416230865672b0b79f9423b607.tsv.gz"
			cadd_tmp="/storage/chenlab/Users/junwang/monkey/data/retnet_cadd.tmp"
			with open(cadd_tmp,"w") as cadd:
				subprocess.run([f'tabix {cadd_tabix} {hg_coor[0]}:{hg_coor[1]}-{hg_coor[1]}'],shell=True,stdout=cadd)
				tmp1=open(cadd_tmp,'r')
				for cadd_line in tmp1:
					cadd_info=cadd_line.rstrip().split()
			#		if cadd_info[0] == hg_coor[0] and cadd_info[1] == hg_coor[1] and cadd_info[3] == hg_coor[2] and cadd_info[4] == hg_coor[3]:
					if cadd_info[0] == hg_coor[0] and cadd_info[1] == hg_coor[1] and cadd_info[2] == hg_coor[2] and cadd_info[3] == hg_coor[3]:

						cadd_score = cadd_info[-1]
				tmp1.close()
			rhe_AF=rhemac_AF[info[1]]
			dbnsfp_value= ".\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t."
			if info[14] in dbNSFP_score:
				dbnsfp_value = dbNSFP_score[info[14]]
			score.write(f'{info[1]}\t{info[14]}\t{info[-1]}\t{info[9]}\t{info[22]}\t{rhe_AF}\t{info[-4]}\t{revel_score}\t{cadd_score}\t{dbnsfp_value}\t{info[24]}\n')
score.close()	
