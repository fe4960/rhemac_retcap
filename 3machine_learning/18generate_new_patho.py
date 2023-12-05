import re
import subprocess
#mk_var_fn="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_all_new_maxAF10_mk_bed_design"
#mk_var_fn="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_bed_design"
mk_var_fn="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_all_new_maxAF10_mk"

mk_var_dt={}
with open(mk_var_fn,"r") as mf:
	for line in mf:
		info=line.split()
		mk_var = info[0]
		hm_var = f'{info[1]}:{info[2]}:{info[4]}:{info[5]}'
		if mk_var not in mk_var_dt:
			mk_var_dt[mk_var]={}
		mk_var_dt[mk_var]["hm_var"] = hm_var
		mk_var_dt[mk_var]["AF"] = info[-3]
		mk_var_dt[mk_var]["AC"] = info[-2]
		mk_var_dt[mk_var]["AN"] = info[-1]
		info1 = info[-4].split(";")
		mk_var_dt[mk_var]["patho"] = info1[1]  





hm_var_fn = "/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_all_new_maxAF10_hm"

hm_var_dt={}

with open(hm_var_fn, "r") as hf:
	for line in hf:
		info = line.split()
		hm_var = f'{info[1]}:{info[2]}:{info[4]}:{info[5]}'
		if hm_var not in hm_var_dt:
			hm_var_dt[hm_var] = {}
		hm_var_dt[hm_var]["AF"] = info[9]
		hm_var_dt[hm_var]["AC"] = info[10]
		hm_var_dt[hm_var]["AN"] = info[11]



mk_var_anno_fn="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_mk_design.vep.vcf"

mk_var_anno={}

with open(mk_var_anno_fn, "r" ) as mf:
	for line in mf:
		info = line.split()
		if (info[0].find("#") != 0) and (len(info)==10):
			#print(line)
			mk_var=f'{info[0]}:{info[1]}:{info[3]}:{info[4]}'
			if (len(info[3])==1) and (len(info[4])==1)  :
				info1=info[7].split("|")
				var_type = info1[1]
				var_gene = info1[3]
				var_aa = info1[15].replace("*","X")
				var_aa1 = re.split("\/", var_aa)
				if mk_var not in mk_var_anno:
					mk_var_anno[mk_var] = {}
				if len(var_aa1) > 1:
					mk_var_anno[mk_var]["var_type"] = var_type
					mk_var_anno[mk_var]["var_gene"] = var_gene			
					mk_var_anno[mk_var]["var_aa_ref"] = var_aa1[0]
					mk_var_anno[mk_var]["var_aa_alt"] = var_aa1[1]
					#print(f'mk:{var_aa1[0]}')
			

			
			

hm_var_anno_fn="monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar.format.sorted.analysis"

hm_var_anno={}


with open(hm_var_anno_fn, "r",encoding="ISO-8859-1") as hf:
	for line in hf:
		info = line.split()
		if line.find("\n") == 0:
			break
		if info[0].find("#") ==-1:

			hm_var = f'{info[0]}:{info[1]}:{info[2]}:{info[3]}'
			hm_var = hm_var.replace("chr","")
			var_gene = info[11]
			var_type = info[13]
			info1 = info[14].replace(",",":").split(":")
			if hm_var not in hm_var_anno:
				hm_var_anno[hm_var] = {}
			if len(info1) > 4:

				var_aa = info1[4].replace("p.","")
				var_aa2=re.split("\d+",var_aa)
				if len(var_aa2) >1:
					hm_var_anno[hm_var]["var_type"] = var_type
					hm_var_anno[hm_var]["var_gene"] = var_gene
					hm_var_anno[hm_var]["var_aa_ref"] = var_aa2[0]
					hm_var_anno[hm_var]["var_aa_alt"] = var_aa2[1]
					hm_var_anno[hm_var]["HGMD"] = info[21] 
					#print(f'hm:{var_aa2[0]}')
					
		
		
			

dbNSFP="monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar.dbNSFP"

#tabix="/storage/chen/home/jw29/software/htslib-1.6/tabix"
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


tabix="/storage/chen/home/jw29/software/htslib-1.6/tabix"

score_output="monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_simple_score_extend_all"
#score_output="monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_simple_score_extend_all_1"

score=open(score_output,"w")

score.write("rhemac_coor\thg19_coor\tclinvar\trhemac_var\thg_var\trhemac_AF\tgnomad_AF\trevel\tcadd\tsift\tpolyphen2\tmutationAssessor\tMetaSVM_score\tMetaLR_score\tphyloP100way_vertebrate\tphyloP20way_mammalian\tphastCons100way_vertebrate\tphastCons20way_mammalian\tLRT\tMutationTaster\tFATHMM\tPROVEAN\tVEST3\tMutPred\tDANN\tGERP\tHGMD\trhemac_AN\n")

for mk_var in mk_var_anno:

	if mk_var in mk_var_dt:

		hm_var = mk_var_dt[mk_var]["hm_var"]
		hg_coor = hm_var.split(":")
		print("enter")
		if ("var_aa_ref" in mk_var_anno[mk_var] ) and ("var_aa_ref" in hm_var_anno[hm_var] ):
			print(f'{mk_var}\t{hm_var}')
			print(f'enter1\t{mk_var_anno[mk_var]["var_aa_ref"]}\t{hm_var_anno[hm_var]["var_aa_ref"]}\t{mk_var_anno[mk_var]["var_aa_alt"]}\t{hm_var_anno[hm_var]["var_aa_alt"]}')
			if (mk_var_anno[mk_var]["var_aa_ref"] == hm_var_anno[hm_var]["var_aa_ref"]) and (mk_var_anno[mk_var]["var_aa_alt"] == hm_var_anno[hm_var]["var_aa_alt"]) and ( mk_var_anno[mk_var]["var_gene"] == hm_var_anno[hm_var]["var_gene"]  )  :
				print("enter2")
				revel_tmp="/storage/chenlab/Users/junwang/monkey/data/retnet_revel1.tmp"
				revel_score = "."
				revel_tabix="/storage/chen/home/jw29/RPE65/data/revel_all_chromosomes_out.gz"
				with open(revel_tmp,'w') as revel:
					subprocess.run([f'{tabix} {revel_tabix} {hg_coor[0]}:{hg_coor[1]}-{hg_coor[1]}'],shell=True,stdout=revel)
					tmp=open(revel_tmp,'r')
					for revel_line in tmp:
						revel_info=revel_line.rstrip().split()
						if revel_info[0] == hg_coor[0] and revel_info[1] == hg_coor[1] and revel_info[3] == hg_coor[2] and revel_info[4] == hg_coor[3]:
							revel_score=revel_info[-1]
					tmp.close()

				cadd_score = "."
			#cadd_tabix = "/storage/chenlab/Users/junwang/monkey/data/retcap/CADD/GRCh37-v1.6_simple_3-31-23.gz"
				#cadd_tabix = "/storage/chenlab/Users/junwang/monkey/data/retcap/GRCh37-v1.6_simple_4-22-23.gz"
				cadd_tabix = "/storage/chenlab/Users/junwang/monkey/data/retcap/CADD/GRCh37-v1.6_clinvar.tsv.gz"
				cadd_tmp="/storage/chenlab/Users/junwang/monkey/data/retnet_cadd1.tmp"
				with open(cadd_tmp,"w") as cadd:
					subprocess.run([f'{tabix} {cadd_tabix} {hg_coor[0]}:{hg_coor[1]}-{hg_coor[1]}'],shell=True,stdout=cadd)
					tmp1=open(cadd_tmp,'r')
					for cadd_line in tmp1:
						cadd_info=cadd_line.rstrip().split()
						if cadd_info[0] == hg_coor[0] and cadd_info[1] == hg_coor[1] and cadd_info[2] == hg_coor[2] and cadd_info[3] == hg_coor[3]:
							cadd_score = cadd_info[-1]
					tmp1.close()
	 	
				dbnsfp_value= ".\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t."

				if hm_var in dbNSFP_score:
					dbnsfp_value = dbNSFP_score[hm_var]

#				score.write(f'{mk_var}\t{hm_var}\t{mk_var_dt[mk_var]["patho"]}\t{mk_var_anno[mk_var]["var_type"]}\t{hm_var_anno[hm_var]["var_type"]}\t{mk_var_dt[mk_var]["AF"]}\t{hm_var_dt[hm_var]["AF"]}\t{revel_score}\t{cadd_score}\t{dbnsfp_value}\t{hm_var_anno[hm_var]["HGMD"]}\t{mk_var_dt[mk_var]["AN"]}\n')
				score.write(f'{mk_var}\t{hm_var}\t{mk_var_dt[mk_var]["patho"]}\t{mk_var_anno[mk_var]["var_type"]}\t{hm_var_anno[hm_var]["var_type"]}\t{mk_var_dt[mk_var]["AF"]}\t{hm_var_dt[hm_var]["AF"]}\t{revel_score}\t{cadd_score}\t{dbnsfp_value}\t{hm_var_anno[hm_var]["HGMD"]}\t{mk_var_dt[mk_var]["AN"]}\n')


score.close()

