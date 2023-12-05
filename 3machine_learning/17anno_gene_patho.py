AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8_clean"
AF_dict={}
header_dict={}
colony=["het","hom"]
col_dt={}
con_dt={}
colony1=["Cayo_AC","CNPRC_AC","NEPRC_AC","ONPRC_AC","SNPRC_AC","TNPRC_AC","WNPRC_AC","YNPRC_AC"]
with open(AF_file, "r") as af:
	header=next(af)
	header_info=header.rstrip().split("\t")
	for i in range(len(header_info)):
		header_dict[header_info[i]]=i
	for line in af:
		info=line.rstrip().split("\t")
		AF_dict[info[0]]=""
		for col in colony:
			if int(info[header_dict[col]]) > 0:
				AF_dict[info[0]]+= f'{col}:{info[header_dict[col]]};'
				if info[0] not in con_dt:
					con_dt[info[0]]=0
				con_dt[info[0]]+=int(info[header_dict[col]])
		for col in colony1:
			if int(info[header_dict[col]]) > 0:
				if info[0] not in col_dt:
					col_dt[info[0]]={}
				col_dt[info[0]][col]=info[header_dict[col]]

autism_gene="/storage/chen/home/jw29/monkey/data/Autism_gene"
autism_gene_dict={}
with open(autism_gene,"r") as asd:
	for line in asd:
		line1=line.rstrip()
		autism_gene_dict[line1]=1

target_gene="/storage/chenlab/Users/junwang/monkey/data/retcap/panel.100416.liftover.design.txt_gene_final"
target_gene_dict={}
with open(target_gene,"r") as tg:
	for line in tg:
		line1=line.rstrip()
		target_gene_dict[line1]=1

file1="monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen"
var={}
with open(file1,"r") as fl:
	for line in fl:
		info=line.split("\t")
		if info[1] not in var:
			var[info[1]]={}
		var[info[1]]["mac"]=info[6]
		var[info[1]]["hm"]=info[20]

#file2="monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_patho_extend_all_patho_flt_new"
#file2="monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_patho_extend_all_patho_new_maxAF10_flt_new1"
file2="monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_patho_extend_all_patho_flt_new_maxAF10"

out=f'{file2}_gene'
fl2=open(out,"w")
with open(file2,"r") as fl:
	for line in fl:
		info=line.split("\t")
		line1=line.strip()
		mac_label="NA"
		hm_label="NA"
		if info[0] in var:
			if var[info[0]]["mac"] in autism_gene_dict:
				mac_label="ND"
			elif var[info[0]]["mac"] in target_gene_dict: 
				mac_label="IRD"
				print("enter")

			if var[info[0]]["hm"] in autism_gene_dict:	
				hm_label="ND"
			elif var[info[0]]["hm"] in target_gene_dict:
				hm_label="IRD"
				print("enter")
			col_num=len(col_dt[info[0]].keys())
			rhe_num=con_dt[info[0]]
			fl2.write(f'{line1}\t{var[info[0]]["mac"]}\t{var[info[0]]["hm"]}\t{mac_label}\t{hm_label}\t{AF_dict[info[0]]}\t{col_num}\t{rhe_num}\n')
		else:
			if info[0] in AF_dict:
				print(f'{info[0]}\t{AF_dict[info[0]]}\n')
fl2.close()
	
