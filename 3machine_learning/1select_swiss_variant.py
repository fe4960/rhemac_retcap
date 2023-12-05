import gzip

main="/storage/chenlab/Users/junwang"
gf=f'{main}/monkey/data/retcap/target_gene_with_var_new2_rm8'
gl={}
with open(gf, "r") as gf1:
	for line in gf1:
		info=line.rstrip().split()
		gl[info[0]]=1

#fn="/storage/chenlab/Users/junwang/reference/clinvar_20230508.vcf.gz"
patho_file="reference/humsavar_swissVar.txt"
patho={}
with open(patho_file,"r") as pa:
	for i in range(44):
		next(pa)
	for line in pa:
		#print(line)
		info=line.split()
		if len(info) >=4:
			print(info[0])
			var=info[0]+":"+info[3]
			patho[var]=info[4]

fn="/storage/chenlab/Users/junwang/monkey/data/retcap/swissvar.vcf"
of=f'{main}/monkey/data/retcap/target_gene_with_var_new2_rm8_swiss'
out=open(of,"w")
with open(fn,"r") as fl:
	for line in fl:
		info=line.rstrip().split()

		if (line.find("#") != 0) and (len(info) >= 5) :
			#print(line)
#1       94458509        873737  A       G       .       .       ALLELEID=864838;CLNDISDB=MedGen:CN239167;CLNDN=ABCA4-Related_Disorders;CLNHGVS=NC_000001.10:g.94458509A>G;CLNREVSTAT=criteria_provided,_single_submitter;CLNSIG=Uncertain_significance;CLNVC=single_nucleotide_variant;CLNVCSO=SO:0001483;CLNVI=Illumina_Laboratory_Services,_Illumina:928981;GENEINFO=ABCA4:24;MC=SO:0001624|3_prime_UTR_variant;ORIGIN=1;RS=1658908697
#	for line in fl:
		#print(line)	
			info1=info[2].split(":")
			gene=info1[0]
			sig=patho[info[2]]
#			for info2 in info1:
#				if info2.find("GENEINFO=") == 0 :
#					info3=info2.replace(":","=").split("=")
#					gene=info3[1]
#				if info2.find("CLNSIG=") == 0 :
#					info3=info2.split("=")
#					sig=info3[1]
		
			if gene in gl:
				out.write(f'{info[0]}\t{info[1]}\t{info[2]}\t{info[3]}\t{info[4]}\t.\t.\t{gene};{sig}\n')

out.close()

	
