from os.path import exists
import subprocess
import re
codon={}
codon["TTT"]="F"
codon["TTC"]="F"
codon["TTA"]="L"
codon["TTG"]="L"
codon["CTA"]="L"
codon["CTG"]="L"
codon["CTT"]="L"
codon["CTC"]="L"
codon["ATA"]="I"
codon["ATC"]="I"
codon["ATT"]="I"
codon["ATG"]="M"
codon["GTA"]="V"
codon["GTC"]="V"
codon["GTT"]="V"
codon["GTG"]="V"
codon["TCA"]="S"
codon["TCT"]="S"
codon["TCG"]="S"
codon["TCC"]="S"
codon["CCT"]="P"
codon["CCA"]="P"
codon["CCC"]="P"
codon["CCG"]="P"
codon["ACA"]="T"
codon["ACT"]="T"
codon["ACG"]="T"
codon["ACC"]="T"
codon["GCT"]="A"
codon["GCA"]="A"
codon["GCC"]="A"
codon["GCG"]="A"
codon["TAT"]="Y"
codon["TAC"]="Y"
codon["TAA"]="*"
codon["TAG"]="*"
codon["CAT"]="H"
codon["CAC"]="H"
codon["CAA"]="Q"
codon["CAG"]="Q"
codon["AAT"]="N"
codon["AAC"]="N"
codon["AAG"]="K"
codon["AAA"]="K"
codon["GAT"]="D"
codon["GAC"]="D"
codon["GAG"]="E"
codon["GAA"]="E"
codon["TGG"]="W"
codon["TGA"]="*"
codon["TGC"]="C"
codon["TGT"]="C"
codon["CGT"]="R"
codon["CGC"]="R"
codon["CGG"]="R"
codon["CGA"]="R"
codon["AGA"]="R"
codon["AGG"]="R"
codon["AGT"]="S"
codon["AGC"]="S"
codon["GGG"]="G"
codon["GGC"]="G"
codon["GGA"]="G"
codon["GGT"]="G"


retnet="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8"
#retnet="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var"
retnet_gene={}
with open(retnet,'r') as ro:
	for line in ro:
		gene=line.split()
		retnet_gene[gene[0]]=1

tmp="/storage/chenlab/Users/junwang/monkey/data/retnet/Homo_sapiens.GRCh37.87.gff3"
gnomad="/storage/chenlab/Users/junwang/gnomAD/gnomad.exomes.r2.1.1.sites.vcf.bgz"
gene_PNS_hm={}
with open(tmp,"r") as gf:
	for line in gf:
		if not re.search("^#",line):
	#		next(gf)
	#	else:
			info=line.split("\t")
			info1=info[8].split(";")
			if info[2] == "gene":
				info2=info1[1].split("=")
				if info2[1] in retnet_gene:
				#1       ensembl_havana  gene    20301925        20306932        .       -       .       ID=gene:ENSG00000188257;Name=PLA2G2A;biotype=protein_coding;description=phospholipase A2%2C group IIA (platelets%2C synovial fluid) [Source:HGNC Symbol%3BAcc:9031];gene_id=ENSG00000188257;logic_name=ensembl_havana_gene;version=6
					start=info[3]
					end=info[4]
					chrom=info[0]	
					tmp_file="/storage/chenlab/Users/junwang/monkey/scripts/retcap/tabix_tmp"

					tmp1=open(tmp_file,"w")
					subprocess.run(f'tabix {gnomad} {chrom}:{start}-{end}',shell=True,stdout=tmp1)
					tmp1.close()
					with open(tmp_file,"r") as tmp2:
						for line2 in tmp2:
							info2=line2.split()
							info3=info2[7].split(";")
							info4=info3[-1].split(",")
							af = info3[2].split("=")
							for trans4 in info4:
								trans_info4 =trans4.split("|")
								if (len(trans_info4)>=6): #and (float(af[1]) >0.05):
			#					if (len(trans_info4)>=6) and (float(af[1]) >0.01):
	
									if (re.search("missense_variant",trans_info4[1]) or re.search("stop_gained",trans_info4[1])):
										if trans_info4[3] not in gene_PNS_hm:
											gene_PNS_hm[trans_info4[3]]={}
											gene_PNS_hm[trans_info4[3]][trans_info4[6]]={}
											gene_PNS_hm[trans_info4[3]][trans_info4[6]]["PN"]=1
										else:
											if trans_info4[6] not in gene_PNS_hm[trans_info4[3]]:
												gene_PNS_hm[trans_info4[3]][trans_info4[6]]={}
												gene_PNS_hm[trans_info4[3]][trans_info4[6]]["PN"]=1
											else:
												if "PN" in gene_PNS_hm[trans_info4[3]][trans_info4[6]]:
													 gene_PNS_hm[trans_info4[3]][trans_info4[6]]["PN"]+=1
												else:
													gene_PNS_hm[trans_info4[3]][trans_info4[6]]["PN"]=1

									if re.search("synonymous_variant",trans_info4[1]):
										if trans_info4[3] not in gene_PNS_hm:
											gene_PNS_hm[trans_info4[3]]={}
											gene_PNS_hm[trans_info4[3]][trans_info4[6]]={}
											gene_PNS_hm[trans_info4[3]][trans_info4[6]]["PS"]=1
										else:
											if trans_info4[6] not in gene_PNS_hm[trans_info4[3]]:
												gene_PNS_hm[trans_info4[3]][trans_info4[6]]={}
												gene_PNS_hm[trans_info4[3]][trans_info4[6]]["PS"]=1
											else:
												if "PS" in gene_PNS_hm[trans_info4[3]][trans_info4[6]]:
													gene_PNS_hm[trans_info4[3]][trans_info4[6]]["PS"]+=1
												else:
												 	gene_PNS_hm[trans_info4[3]][trans_info4[6]]["PS"]=1

															
#vep=C|downstream_gene_variant|MODIFIER|WASH7P|ENSG00000227232|Transcript|ENST00000423562|unprocessed_pseudogene|											 
#tabix /storage/chenlab/Users/junwang/gnomAD/gnomad.exomes.r2.1.1.sites.vcf.bgz 1:1000-100000

AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8_clean"
#AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap"
rhemac_AF={}
with open(AF_file,'r') as af:
	next(af)
	for line in af:
		info=line.split()
		rhemac_AF[info[0]]=info[-1]
var_file="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_var.vep.101"
#var_file="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8"
#var_file="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_updated_new_gnomad_clinvar_retnet"
#var_file="/storage/chenlab/Users/junwang/monkey/data/database/variant_table_rhemac10_var_GVCFs.10.vep.101_updated"
#1       10735   .       A       T       .       PASS    CSQ=T|missense_variant|MODERATE||ENSMMUG00000023296|Transcript|ENSMMUT00000032773|protein_coding|3/3||||177|46|16|S/T|Tca/Aca|||-1||SNV|||YES|||||ENSMMUP00000030665||I0FQU3|UPI0000D99EE8||Ensembl|||PANTHER:PTHR47055&PANTHER:PTHR47055:SF2||||||||||||||||||||||||||||||,T|upstream_gene_variant|MODIFIER|U6|ENSMMUG00000036181|Transcript|ENSMMUT00000051915|snRNA|||||||||||3532|1||SNV|RFAM||YES||||||||||Ensembl|||||||||||||||||||||||||||||||||,T|missense_variant|MODERATE|PGBD2|114678393|Transcript|XM_028848769.1|protein_coding|3/3||||890|46|16|S/T|Tca/Aca|||-1||SNV|EntrezGene||YES|||||XP_028704602.1|||||RefSeq|||||||||||||||||||||||||||||||||,T|upstream_gene_variant|MODIFIER|LOC114674980|114674980|Transcript|XR_003726072.1|snRNA|||||||||||3532|1||SNV|EntrezGene||YES||||||||||RefSeq|||||||||||||||||||||||||||||||||      GT:AD:DP:GQ     0/1:0,100:100:200

gene_PNS={}
import re

with open(var_file,"r") as var:
	for line in var:
		if not re.search("^#",line):
			info=line.split()
			info1 = info[7].split(",")
			var_pos=f'{info[0]}:{info[1]}:{info[3]}:{info[4]}'
			for trans in info1:
				trans_info =trans.split("|")
				if (var_pos in rhemac_AF) and (len(trans_info)>=6): 
					if (float(rhemac_AF[var_pos]) >=0):

#					if (float(rhemac_AF[var_pos]) >0.01):
						if (re.search("missense_variant",trans_info[1]) or re.search("stop_gained",trans_info[1])):
							if trans_info[3] not in gene_PNS:
								gene_PNS[trans_info[3]]={}
								gene_PNS[trans_info[3]][trans_info[6]]={}
								gene_PNS[trans_info[3]][trans_info[6]]["PN"]=1
							else:
								if trans_info[6] not in gene_PNS[trans_info[3]]:
									gene_PNS[trans_info[3]][trans_info[6]]={}
									gene_PNS[trans_info[3]][trans_info[6]]["PN"]=1
								else:
									if "PN" in gene_PNS[trans_info[3]][trans_info[6]]:
										 gene_PNS[trans_info[3]][trans_info[6]]["PN"]+=1
									else:
										gene_PNS[trans_info[3]][trans_info[6]]["PN"]=1

						if re.search("synonymous_variant",trans_info[1]):
							if trans_info[3] not in gene_PNS:
								gene_PNS[trans_info[3]]={}
								gene_PNS[trans_info[3]][trans_info[6]]={}
								gene_PNS[trans_info[3]][trans_info[6]]["PS"]=1
							else:
								if trans_info[6] not in gene_PNS[trans_info[3]]:
									gene_PNS[trans_info[3]][trans_info[6]]={}
									gene_PNS[trans_info[3]][trans_info[6]]["PS"]=1
								else:
									if "PS" in gene_PNS[trans_info[3]][trans_info[6]]:
										gene_PNS[trans_info[3]][trans_info[6]]["PS"]+=1
									else:
									 	gene_PNS[trans_info[3]][trans_info[6]]["PS"]=1

						
gene_pair="/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair"
gene_NS={}
#output=f'{gene_pair}_MK_gnomad_AF0.01'

output=f'{gene_pair}_MK_gnomad_AF'
op=open(output,"w")
with open(gene_pair,"r") as gp:
	for line in gp:
		info=line.split()
		hm_info=info[0].split("|")
		rm_info=info[1].split("|")
		align_file=f'/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_fasta/{hm_info[0]}_{hm_info[1]}_{rm_info[1]}_DNA.fasta'
		align_file1=f'/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_fasta/{hm_info[0]}_{hm_info[1]}_{rm_info[1]}_AA.fasta'
		if exists(align_file) and exists(align_file1): 
			print(align_file)
			af=open(align_file,"r")
			next(af)
			n=3
			hm_nt_seq=next(af).rstrip()
			hm_nt=[hm_nt_seq[index:index+n:] for index in range(0,len(hm_nt_seq),n)]
			next(af)
			rm_nt_seq=next(af).rstrip()
			rm_nt=[rm_nt_seq[index:index+n:] for index in range(0, len(rm_nt_seq),n)]
			af1=open(align_file1,"r")
			next(af1)
			hm_aa=next(af1).rstrip()[0::1]
			next(af1)
			rm_aa=next(af1).rstrip()[0::1]
			N=0
			S=0
			for i, item in enumerate(hm_nt):
				hm_nt_sub=item[0::1]
				rm_nt_sub=rm_nt[i][0::1]
				hm_aa_sub=hm_aa[i]
				rm_aa_sub=rm_aa[i]
#				print(hm_nt_sub)
#				print(rm_nt_sub)
#				print(hm_aa_sub)
#				print(rm_aa_sub)
#			if hm_aa_sub == rm_aa_sub:
#				if hm_nt_sub
				if (item != "---") and (rm_nt[i] != "---"):
					if rm_nt_sub[0] != hm_nt_sub[0]:
				#	codon_origin_hm = hm_aa_sub
						if f'{rm_nt_sub[0]}{hm_nt_sub[1]}{hm_nt_sub[2]}' in codon:
							codon_change = codon[f'{rm_nt_sub[0]}{hm_nt_sub[1]}{hm_nt_sub[2]}']
							if hm_aa_sub == codon_change:
								S+=1
							else:
								N+=1
					#	else:
		#					N+=1
					if rm_nt_sub[1] != hm_nt_sub[1]:
#					codon_origin_hm = hm_aa_sub
						if f'{hm_nt_sub[0]}{rm_nt_sub[1]}{hm_nt_sub[2]}' in codon:
							codon_change = codon[f'{hm_nt_sub[0]}{rm_nt_sub[1]}{hm_nt_sub[2]}']
							if hm_aa_sub == codon_change:
								S+=1
							else:
								N+=1
					#	else:
		#					N+=1
					if rm_nt_sub[2] != hm_nt_sub[2]:
#					codon_origin_hm = hm_aa_sub
						if f'{hm_nt_sub[0]}{hm_nt_sub[1]}{rm_nt_sub[2]}' in codon:
							codon_change = codon[f'{hm_nt_sub[0]}{hm_nt_sub[1]}{rm_nt_sub[2]}']
							if hm_aa_sub == codon_change:
								S+=1
							else:
								N+=1
					#	else:
		#					N+=1

		#gene_NS[hm_info[0]]["DN"]=N	
		#gene_NS[hm_info[0]]["DS"]=S
			PN=0
			PS=0
			if (hm_info[0] in gene_PNS) and (rm_info[1] in gene_PNS[hm_info[0]]):
				if "PN" in gene_PNS[hm_info[0]][rm_info[1]]:
					PN = gene_PNS[hm_info[0]][rm_info[1]]["PN"]

				if "PS" in gene_PNS[hm_info[0]][rm_info[1]]:
					PS = gene_PNS[hm_info[0]][rm_info[1]]["PS"]


			if (hm_info[0] in gene_PNS_hm) and (hm_info[1] in gene_PNS_hm[hm_info[0]]):
				if "PN" in gene_PNS_hm[hm_info[0]][hm_info[1]]:
					PN+=gene_PNS_hm[hm_info[0]][hm_info[1]]["PN"]

				if "PS" in gene_PNS_hm[hm_info[0]][hm_info[1]]:
					PS+=gene_PNS_hm[hm_info[0]][hm_info[1]]["PS"]
			#[trans_info[6]][PS]
			op.write(f'{hm_info[0]}\t{hm_info[1]}\t{rm_info[1]}\t{N}\t{S}\t{PN}\t{PS}\n')
op.close()
			
		
		
		
