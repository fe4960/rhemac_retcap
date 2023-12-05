import re
import subprocess
#retnet="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new"
retnet="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8"
retnet_gene={}
with open(retnet,'r') as ro:
	for line in ro:
		gene=line.split()
		retnet_gene[gene[0]]=1

#gff3="/storage/chenlab/Users/junwang/monkey/data/retnet/Homo_sapiens.GRCh37.87.gff3.gz"
gff3="/storage/chenlab/Users/junwang/monkey/data/retnet/Macaca_mulatta.Mmul_10.101.gff3.gz"
gene_dict={}
trans=""
gene=""
#tmp="/storage/chenlab/Users/junwang/monkey/data/retnet/Homo_sapiens.GRCh37.87.gff3"
tmp="/storage/chenlab/Users/junwang/monkey/data/retnet/Macaca_mulatta.Mmul_10.101.gff3"

output2=f'{gff3}_cds_len'
op2=open(output2,"w")
tp=open(tmp, "w")
subprocess.run([f'gunzip -c {gff3}'],shell=True,stdout=tp)
tp.close()
#gf=open(tmp, "r") 
with open(tmp,"r") as gf:
	for line in gf:
		match=re.search("^#",line)
		if not match:
	#		next(gf)
	#	else:
			info=line.split("\t")
			info1=info[8].split(";")
			if info[2] == "gene":
				info2=info1[1].split("=")
				if info2[1] in retnet_gene:
					info3=info1[0].split(":")
					if info3[1] not in gene_dict:
						gene_dict[info3[1]]={}
						gene_dict[info3[1]]["gene"]=info2[1]
						gene_dict[info3[1]]["trans"]={}
					else:
						gene_dict[info3[1]]["gene"]=info2[1]
						gene_dict[info3[1]]["trans"]={}
			if (info[2] == "mRNA"): # or (info[2] == "NMD_transcript_variant"):
				info4=info1[0].split(":")
				info5=info1[1].split(":")
				#if info5[1] in gene_dict:
				trans=info4[1]
				gene =info5[1]
#						gene_dict[info5[1]]["trans"]=info2[1]
			if info[2] == "CDS":
				info6=info1[1].split(":")
				cds_len = int(info[4])-int(info[3])+1
				if trans == info6[1]:
					if gene in gene_dict:
						if "trans" not in gene_dict[gene]:
							gene_dict[gene]["trans"]={}
							gene_dict[gene]["trans"][trans]=0
							gene_dict[gene]["trans"][trans]+=cds_len
						else:
							if trans not in gene_dict[gene]["trans"]:
								gene_dict[gene]["trans"][trans]=0;
								gene_dict[gene]["trans"][trans]+=cds_len
							else:
								gene_dict[gene]["trans"][trans]+=cds_len
				op2.write(f'{trans}\t{cds_len}\n')
op2.close()
		
output=f'{gff3}_max_cds_mRNA'
output1=f'{gff3}_all_mRNA'
op=open(output,"w")
op1=open(output1,"w")
for gen_key in gene_dict:
#	sorted_keys =sorted(gene_dict[gen_key]["trans"].items(),key=lambda item: item[1])
	sorted_keys =sorted(gene_dict[gen_key]["trans"],key=gene_dict[gen_key]["trans"].get)
#	print(f'{sorted_keys}')
	if len(sorted_keys) > 0:
		max_key=sorted_keys[-1]
		op.write(f'{gene_dict[gen_key]["gene"]}\t{gen_key}\t{max_key}\t{gene_dict[gen_key]["trans"][max_key]}\n')
	else:
		print(f'{gen_key}')
									
	for keys in gene_dict[gen_key]["trans"]:
		op1.write(f'{gene_dict[gen_key]["gene"]}\t{gen_key}\t{keys}\t{gene_dict[gen_key]["trans"][keys]}\n')	
op.close()
op1.close()

				
	
#1       ensembl_havana  gene    94458393        94586688        .       -       .       ID=gene:ENSG00000198691;Name=ABCA4;biotype=protein_coding;description=ATP-binding cassette%2C sub-family A (ABC1)%2C member 4 [Source:HGNC Symbol%3BAcc:34];gene_id=ENSG00000198691;logic_name=ensembl_havana_gene;version=7
#1       ensembl_havana  mRNA    94458393        94586688        .       -       .       ID=transcript:ENST00000370225;Parent=gene:ENSG00000198691;Name=ABCA4-001;biotype=protein_coding;ccdsid=CCDS747.1;havana_transcript=OTTHUMT00000029320;havana_version=1;tag=basic;transcript_id=ENST00000370225;version=3
#1       ensembl_havana  three_prime_UTR 94458393        94458792        .       -       .       Parent=transcript:ENST00000370225
#1       ensembl_havana  exon    94458393        94458798        .       -       .       Parent=transcript:ENST00000370225;Name=ENSE00001452110;constitutive=0;ensembl_end_phase=-1;ensembl_phase=0;exon_id=ENSE00001452110;rank=50;version=1
#1       ensembl_havana  CDS     94458793        94458798        .       -       0       ID=CDS:ENSP00000359245;Parent=transcript:ENST00000370225;protein_id=ENSP00000359245
				

