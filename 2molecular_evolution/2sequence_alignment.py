import re
import subprocess 
import os
rhemac="/storage/chenlab/Users/junwang/monkey/data/retnet/Macaca_mulatta.Mmul_10.101.gff3.gz_max_cds_mRNA"
human="/storage/chenlab/Users/junwang/monkey/data/retnet/Homo_sapiens.GRCh37.87.gff3.gz_max_cds_mRNA"
#SDCCAG8 ENSMMUG00000019994      ENSMMUT00000069525      2514
rm_gene={}
hm_gene={}
with open(rhemac,"r") as rm:
	for line in rm:
		info=line.split()
		rm_gene[info[2]]=info[0]

with open(human,"r") as hm:
	for line in hm:
		info=line.split()
		hm_gene[info[2]]=info[0]

#less /storage/chenlab/Users/junwang/monkey/data/retnet/Homo_sapiens.GRCh37.cds.all.fa.gz

rhemac_fa="/storage/chenlab/Users/junwang/monkey/data/retnet/Macaca_mulatta.Mmul_10.cds.all.release101.fa"
seq={}
#>ENSMMUT00000085913.1 cds primary_assembly:Mmul_10:7:168140272:168140649:-1 gene:ENSMMUG00000057110.1 gene_biotype:IG_D_gene transcript_biotype:IG_D_gene
flag=0
gene=""
trans=""
with open(rhemac_fa,"r") as rhe:
	for line in rhe:
		if re.search("^>",line):
			info=line.split()
			trans0=info[0][1::].split(".")
			trans=trans0[0]
#			print(trans)
#			print(gene)
			if trans in rm_gene:
				gene=rm_gene[trans]
				flag=1
				if gene not in seq:
					seq[gene]={}
					seq[gene]["rhemac"]={}
				else:
					seq[gene]["rhemac"]={}
			else:
				flag=0
		else:
			if re.search("^\S",line):
				if flag==1:
					if trans not in seq[gene]["rhemac"]:
#						print(trans)
						seq[gene]["rhemac"][trans]=f'{line}'
					else:
						seq[gene]["rhemac"][trans]+=f'{line}'
					#print(f'{seq[gene]["rhemac"][trans]}')

human_fa="/storage/chenlab/Users/junwang/monkey/data/retnet/Homo_sapiens.GRCh37.cds.all.fa"
flag=0
with open(human_fa,"r") as hum:
	for line in hum:
		if re.search("^>",line):
			info=line.split()
			trans0=info[0][1::].split(".")
			trans=trans0[0]
		#	print(trans)
		#	print(gene)
			if trans in hm_gene:
				gene=hm_gene[trans]
				flag=1
				if gene not in seq:
					seq[gene]={}
					seq[gene]["human"]={}
				else:
					seq[gene]["human"]={}

			else:
				flag=0
		else:
			if re.search("^\S",line):
				if flag==1:
					if trans not in seq[gene]["human"]:
			#		print(gene)
						seq[gene]["human"][trans]=f'{line}'
					else:
						seq[gene]["human"][trans]+=f'{line}'

hm_seq_file="/storage/chenlab/Users/junwang/monkey/data/retcap/hm_retnet_cds.fa"
rm_seq_file="/storage/chenlab/Users/junwang/monkey/data/retcap/rm_retnet_cds.fa"
gene_pair="/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair"
dir1="/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_fasta/"
os.mkdir(dir1)

op=open(gene_pair,"w")
op1=open(rm_seq_file,"w")
op2=open(hm_seq_file,"w")
for gene in seq:
#	print(gene)
	keys=seq[gene].keys()
	print(keys)
	if ("rhemac" in seq[gene]) and ("human" in seq[gene]):
		rhemac_id=list(seq[gene]["rhemac"].keys())[0]
		human_id=list(seq[gene]["human"].keys())[0]
		print(rhemac_id)
		print(human_id)
		op.write(f'{gene}|{human_id}\t{gene}|{rhemac_id}\n')
		op1.write(f'>{gene}|{rhemac_id}\n{seq[gene]["rhemac"][rhemac_id]}')
		op2.write(f'>{gene}|{human_id}\n{seq[gene]["human"][human_id]}')
		output3=f'/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_fasta/{gene}_{human_id}_{rhemac_id}.fa'
		output4=f'/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_fasta/{gene}_{human_id}_{rhemac_id}'
		tmp_log=f'/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_fasta/{gene}_{human_id}_{rhemac_id}.log'
		op3=open(output3,"w")
		op3.write(f'>{gene}|{human_id}\n{seq[gene]["human"][human_id]}\n>{gene}|{rhemac_id}\n{seq[gene]["rhemac"][rhemac_id]}\n')
		op3.close()
		tp_log=open(tmp_log,"w")
		subprocess.run(f'java -jar -Xmx20000m /storage/chen/home/jw29/software/macse_v0.9b1.jar -i {output3} -o {output4}',shell=True,stdout=tp_log)
		tp_log.close()

op.close()
op1.close()
op2.close()
#>ENST00000415118.1 havana_ig_gene:known chromosome:GRCh37:14:22907539:22907546:1 gene:ENSG00000223997.1 gene_biotype:TR_D_gene transcript_biotype:TR_D_gene			

