import re

filename="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_extend_all"

output="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_patho_extend_all_patho"

out=open(output,"w")
output1="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_benign_extend_all_benign"

out1=open(output1,"w")

out1.write("rhemac_coor\thg19_coor\tclinvar\trhemac_var\thg_var\trhemac_AN\trhemac_hom_gf\trhemac_AF\tgnomad_AF\trevel\tcadd\tsift\tpolyphen2\tmutationAssessor\tMetaSVM_score\tMetaLR_score\tphyloP100way_vertebrate\tphyloP20way_mammalian\tphastCons100way_vertebrate\tphastCons20way_mammalian\tLRT\tMutationTaster\tFATHMM\tPROVEAN\tVEST3\tMutPred\tDANN\tGERP\tHGMD\n")

out.write("rhemac_coor\thg19_coor\tclinvar\trhemac_var\thg_var\trhemac_AN\trhemac_hom_gf\trhemac_AF\tgnomad_AF\trevel\tcadd\tsift\tpolyphen2\tmutationAssessor\tMetaSVM_score\tMetaLR_score\tphyloP100way_vertebrate\tphyloP20way_mammalian\tphastCons100way_vertebrate\tphastCons20way_mammalian\tLRT\tMutationTaster\tFATHMM\tPROVEAN\tVEST3\tMutPred\tDANN\tGERP\tHGMD\n")


with open (filename,"r") as f:
	next(f)
	for line in f:
#11:87781845:A:AT        12:88512304:A:AT        Pathogenic      frameshift_variant      frameshift_insertion    0       0.000917431192660551    1.93594e-03     .       32      .       .       .       MATCH-chr12:88512304:A>AT:CEP290:NM_025114.3:c.1666dupA:Disease_causing_mutation:Leber_congenital_amaurosis:23847139&chr12:88512304:AT>A:CEP290:NM_025114.3:c.1666delA:Disease_causing_mutation:Joubert_syndrome,_Senior-Loken_type:17564967,21228398&
		info=line.split("\t")
		#print(info[13])
#		match = re.search("^MATCH-",info[13])
		match = re.search("^MATCH-",info[28])
		match1 = re.search("^Benign", info[2])
		
		if (match and (not match1) and (info[2] != "Likely_benign")):
#			info1=info[13].split(":")
			info1=info[28].split(":")
			print(info1[7])
			if info1[7] == "Disease_causing_mutation" :
				out.write(f'{line}')
		else:
			if (info[2] =="Likely_pathogenic") or (info[2] =="Pathogenic") or (info[2] =="Pathogenic/Likely_pathogenic"):
				out.write(f'{line}')
			else:
				if (info[2] =="Benign") or (info[2] == "Benign/Likely_benign") or (info[2] == "Likely_benign"):
					out1.write(f'{line}')
out.close()
out1.close() 

