import re
import os
import subprocess
#retnet="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet-01-27-22_sort"
#retnet="monkey/data/retcap/target_gene_with_var"
#retnet="monkey/data/retcap/target_gene_with_var_new1"
retnet="monkey/data/retcap/target_gene_with_var_new2_rm8"

retnet_gene={}
with open(retnet,'r') as ro:
	for line in ro:
		gene=line.split()
		retnet_gene[gene[0]]=1


#variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_updated_new_gnomad"
#variant_output="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_updated_new_gnomad_clinvar_retnet"


#variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_target_updated_gnomad"
#variant_output="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_target_updated_gnomad_clinvar_retnet"

#variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new_corrected_vep101_target_updated_gnomad"
#variant_output="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new_corrected_vep101_target_updated_gnomad_clinvar_retnet"

#variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new1_corrected_vep101_target_updated_gnomad"
#variant_output="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new1_corrected_vep101_target_updated_gnomad_clinvar_retnet"

variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad"
variant_output="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet"


variant_dict={}
var_type={}
hgmd_var={}
clin_var={}
key_var= {"missense_variant":"missense","frameshift_variant":"frameshift","stop_gained":"stopgain","splice_acceptor_variant":"splicing","splice_donor_variant":"splicing"}
key_var_hm = {"frameshift_deletion":"frameshift","frameshift_insertion":"frameshift","nonsynonymous_SNV":"missense","stopgain":"stopgain"}
clin_file="/storage/chenlab/Users/junwang/monkey/data/retnet/clinvar_20221113.vcf.gz"

#clin_file="/storage/chenlab/Users/junwang/monkey/data/retnet/clinvar_20220129.vcf.gz"
with open (variant_output, "w") as vo:
	with open(variant_table,'r', encoding='windows-1252') as vt:
		header=next(vt)
		header1=header.rstrip()
		vo.write(f'{header1}\tclinvar\n')
		for line in vt:
			line1 = line.rstrip()
			info=line.split()
			hg_coor=info[14].split(":")
			if info[6] in retnet_gene:
				CLNSIG="None"
				
				if info[14] != '.':	
				#	print(hg_coor)
#					filename="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new1_corrected_vep101_target_updated_gnomad_clinvar_retnet.tmp"
					filename="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet.tmp"

					with open(filename,"w") as f:
						clin_res=subprocess.run([f'tabix {clin_file} {hg_coor[0]}:{hg_coor[1]}-{hg_coor[1]}'],shell=True,stdout=f)
#						tmp=open ("/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new1_corrected_vep101_target_updated_gnomad_clinvar_retnet.tmp", "r")
						tmp=open ("/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet.tmp", "r")

						for clin_line in tmp:
					#	print(clin_line)
			#1	861332	1019397	G	A	.	.	ALLELEID=1003021;CLNDISDB=MedGen:CN517202;CLNDN=not_provided;CLNHGVS=NC_000001.10:g.861332G>A;CLNREVSTAT=criteria_provided,_single_submitter;CLNSIG=Uncertain_significance;CLNVC=single_nucleotide_variant;CLNVCSO=SO:0001483;GENEINFO=SAMD11:148398;MC=SO:0001583|missense_variant;ORIGIN=1;RS=1640863258
							clin_info=clin_line.split()
							if clin_info[0] == hg_coor[0] and clin_info[1] == hg_coor[1] and clin_info[3] == hg_coor[2] and clin_info[4] == hg_coor[3]:
								patho=clin_info[7].split(";")
								for patho_info in patho:
									patho_info1 = patho_info.split("=")
									if patho_info1[0] == "CLNSIG":
										CLNSIG=patho_info1[1]
										clin_var[info[1]]=1
						tmp.close()
				vo.write(f'{line1}\t{CLNSIG}\n')
				variant_dict[info[1]]=info[-3]
				match=re.search("MATCH-",info[24])
				if match:
					hgmd_var[info[1]]=1

				var_name =info[9].split("&")
				if var_name[0] not in key_var:
					mk_var = "other"
				else:
					mk_var = key_var[var_name[0]]
			
				if mk_var in var_type:
					if 'rhemac' in var_type[mk_var]:
						var_type[mk_var]['rhemac']+=1
					else:
						var_type[mk_var]['rhemac']=1

				else:	
					var_type[mk_var] = {}
					var_type[mk_var]['rhemac']=1

				var_name_hm = info[22]
				if var_name_hm not in key_var_hm:
					hm_var = "other"
				else:	
					hm_var = key_var_hm[var_name_hm]
			
				splice=re.search('splicing', info[19])
				if splice:
					hm_var = "splicing"
			 	
				if hm_var == mk_var:	
					if hm_var in var_type:
						if 'human' in var_type[hm_var]:
							var_type[hm_var]['human']+=1
						else:
							var_type[hm_var]['human']=1

					else:	
						var_type[hm_var] = {}
						var_type[hm_var]['human']=1



output1="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_var_type_target_new2_rm8"
		
#output1="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_var_type_target_new1"
with open(output1, 'w') as vt:
	for var_t in var_type:
		for spec in var_type[var_t]:
			vt.write(f'{var_t}\t{spec}\t{var_type[var_t][spec]}\n')

AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8"

#AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new1"
output_af="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AF_gnomad_rmXY_target_new2_rm8"

#output_af="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AF_gnomad_rmXY_target_new1"
AF={}
with open(output_af, 'w') as outaf:
	with open(AF_file,'r') as af:
		next(af)
		for line in af:
			info=line.split()
			if int(info[-6]) <= 0:
				continue
			info1=info[0].split(':')
			chrom=info1[0]
			start=info1[1]
			ref=info1[2]
			alt=info1[3]
			if info[0] in variant_dict and (chrom != "X") and (chrom != "Y"):
				outaf.write(f'{info[0]}\t{variant_dict[info[0]]}\t{info[-1]}\tAll\n')
				if info[0] in hgmd_var:
					outaf.write(f'{info[0]}\t{variant_dict[info[0]]}\t{info[-1]}\tHGMD\n')
				if info[0] in clin_var:
					outaf.write(f'{info[0]}\t{variant_dict[info[0]]}\t{info[-1]}\tCLINVAR\n')
				if int(info[-6]) ==1:
					if len(ref)==1 and len(alt)==1:
						if "singleton" not in AF:
							AF['singleton']={}
							AF['singleton']['SNP']=1
						else:
							if "SNP" not in AF["singleton"]:
								AF['singleton']['SNP']=1
							else:
								AF['singleton']['SNP']+=1
					else:
						if "singleton" not in AF:
							AF['singleton']={}
							AF['singleton']['INDEL']=1
						else:
							if "INDEL" not in AF["singleton"]:
								AF['singleton']['INDEL']=1
							else:
								AF['singleton']['INDEL']+=1
			
				if float(info[-1]) <= 0.005:
					if len(ref)==1 and len(alt)==1:
						if "<=0.5%" not in AF:
							AF["<=0.5%"]={}
							AF["<=0.5%"]['SNP']=1
						else:
							if "SNP" not in AF["<=0.5%"]:
								AF["<=0.5%"]['SNP']=1
							else:
								AF["<=0.5%"]['SNP']+=1
					else:
						if "<=0.5%" not in AF:
							AF["<=0.5%"]={}
							AF["<=0.5%"]['INDEL']=1
						else:	
							if "INDEL" not in AF["<=0.5%"]:
								AF["<=0.5%"]['INDEL']=1
							else:
								AF["<=0.5%"]['INDEL']+=1
				else:
					if float(info[-1]) <= 0.01:
						if len(ref)==1 and len(alt)==1:
							if "0.5%-1%" not in AF:
								AF["0.5%-1%"]={}
								AF["0.5%-1%"]['SNP']=1
							else:	
								if "SNP" not in AF["0.5%-1%"]:
									AF["0.5%-1%"]['SNP']=1
								else:
									AF["0.5%-1%"]['SNP']+=1
						else:
							if "0.5%-1%" not in AF:
								AF["0.5%-1%"]={}
								AF["0.5%-1%"]['INDEL']=1
							else:	
								if "INDEL" not in AF["0.5%-1%"]:
									AF["0.5%-1%"]['INDEL']=1
								else:
									AF["0.5%-1%"]['INDEL']+=1

					else:
						if float(info[-1]) <= 0.1:
							if len(ref)==1 and len(alt)==1:
								if "1%-10%" not in AF:
									AF["1%-10%"]={}
									AF["1%-10%"]['SNP']=1
								else:
									if "SNP" not in AF["1%-10%"]:
										AF["1%-10%"]['SNP']=1
									else:
										AF["1%-10%"]['SNP']+=1
							else:
								if "1%-10%" not in AF:
									AF["1%-10%"]={}
									AF["1%-10%"]['INDEL']=1
								else:
									if "INDEL" not in AF["1%-10%"]:
										AF["1%-10%"]['INDEL']=1
									else:
										AF["1%-10%"]['INDEL']+=1
			
						else:
							if len(ref)==1 and len(alt)==1:
								if ">10%" not in AF:
									AF[">10%"]={}
									AF[">10%"]['SNP']=1
								else:
									if "SNP" not in AF[">10%"]:
										AF[">10%"]['SNP']=1
									else:
										AF[">10%"]['SNP']+=1
							else:
								if ">10%" not in AF:
									AF[">10%"]={}
									AF[">10%"]['INDEL']=1
								else:
									if "INDEL" not in AF[">10%"]:
										AF[">10%"]['INDEL']=1
									else:
										AF[">10%"]['INDEL']+=1

output="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AF_target_gene_rmXY_target_new2_rm8"

#output="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AF_target_gene_rmXY_target_new1"
with open (output,'w') as op:
	for label in AF:
		for var in AF[label]:
			op.write(f'{label}\t{var}\t{AF[label][var]}\n')


