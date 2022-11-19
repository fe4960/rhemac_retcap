#monkey_table="/storage/chenlab/Users/junwang/monkey/data/database/monkey_table_GVCFs.10_updated_AF"
#monkey_table="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_corrected_updated"
#monkey_table="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_new_corrected_target"
#monkey_table="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_new1_corrected_target"
#monkey_table="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_new1_rm8_corrected_target"
monkey_table="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_new2_rm8_corrected_target"

monkey_list=[]
with open(monkey_table,'r') as mt:
	next(mt)
	for line in mt:
		mk=line.split()
		monkey_list.append(mk[0])
#retnet_overlap="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet-01-27-22_sort"

#retnet_overlap="/storage/chenlab/Users/junwang/monkey/data/retnet/target_gene_final_retnet"
#retnet_overlap_gene={}
#with open(retnet_overlap,'r') as ro:
#	for line in ro:
#		gene=line.split()
#		retnet_overlap_gene[gene[0]]=1
#variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new_corrected_vep101_target_updated_gnomad"
#variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new1_corrected_vep101_target_updated_gnomad"
#variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new1_rm8_corrected_vep101_target_updated_gnomad"
variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad"

#variant_table="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_corrected_vep101_updated_new_gnomad"
#ID      monkey_var_ID   rhemac10_chr    rhemac10_pos    rhemac10_ref    rhemac10_alt    monkey_genename monkey_ensembl_gene     monkey_ensembl_trans    monkey_variant_type     monkey_var_eff  monkey_exon     monkey_cDNA_change      monkey_aa_change        human_ID        hg19_chr        hg19_pos        hg19_ref      hg19_alt        human_var_eff   human_refGene   human_refgene_detail    human_exon_func human_refGene_aa        human_hgmd      human_ada_score human_rf_score  human_rs_dbSNP150       human_Polyphen2 human_SIFT      human_REVEL     human_MutationAssessor  human_CADD      flag    gnomad_AF       gnomad_AC      gnomad_AN
#1       19:36014077:C:A 19      36014077        C       A       ZNF382  ENSMMUG00000016449      ENSMMUT00000023095      synonymous_variant      LOW     exon:4/4        ENSMMUT00000023095:474_acC/acA  ENSMMUT00000023095:130_T        19:37117192:C:A 19      37117192        C       A       exonic  ZNF382  .       synonymous_SNV  ZNF382:NM_001256838:exon5:c.A390A:p.T130T,ZNF382:NM_032825:exon5:c.A393A:p.T131T        .       .       .       .       .       .       .       .      .       PASS,hg19_reference_mismatch    0       0       0
variant_dict={}
multi_allele={}
with open(variant_table,'r', encoding='windows-1252') as vt:
	next(vt)
	for line in vt:
		info=line.split()
		variant_dict[info[1]]=info[6]
		info1=info[1].split(':')
		chrom=info1[0]
		start=info1[1]
#		pos=f'{chrom}:{start}'
#		if pos in multi_allele:
#			multi_allele[pos]+=1
#		else:
#			multi_allele[pos]=1

genotype={}
genotype_order={}
#genotype_order={ x : {} for x in range(42)}
#AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new1"
AF_file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8"
AF={}
transition=0
transversion=0
with open(AF_file,'r') as af:
	next(af)
	for line in af:
		info=line.split()
		if int(info[-6]) > 0:
			info1=info[0].split(':')
			chrom=info1[0]
			start=info1[1]
			ref=info1[2]
			alt=info1[3]
			pos=f'{chrom}:{start}'
			if pos in multi_allele:
				multi_allele[pos]+=1
			else:
				multi_allele[pos]=1

			if (ref == "A" and alt=="G") or (ref == "G" and alt=="A") or (ref == "C" and alt=="T") or (ref == "T" and alt=="C"):
				transition+=1
			if (ref == "A" and alt=="C") or (ref == "A" and alt=="T") or (ref == "G" and alt=="C") or (ref == "G" and alt=="T") or (ref == "C" and alt=="A") or (ref == "T" and alt=="A") or (ref == "C" and alt=="G") or (ref == "T" and alt=="G"):
				transversion+=1
			pos=f'{chrom}:{start}'
		#print(float(info[-1]),"\n")
		#if info[0] in variant_dict  and multi_allele[pos]==1  and float(info[-1]) >= 0.1 and chrom not in "X" and int(info[-7]) > 3250:
		#if info[0] in variant_dict  and multi_allele[pos]==1  and float(info[-1]) >= 0.005 and chrom not in "X" and int(info[-7]) > 3250:
#		if info[0] in variant_dict  and multi_allele[pos]==1  and int(info[-6]) >= 2 and chrom not in "X" and int(info[-7]) > 3250:
			if (multi_allele[pos]==1)  and (int(info[-6]) >= 2) and (chrom not in "X") and (chrom not in "Y") and (int(info[57]) >=200 ):
				AF[info[0]]=info[-1]
				genotype[info[0]]={x:f'{ref}\t{ref}' for x in monkey_list}
				if chrom not in genotype_order:
					genotype_order[chrom]={}
				else:
					genotype_order[chrom][start]=info[0]
#trans_file="/storage/chenlab/Users/junwang/monkey/data/retcap/trans_file"
#trans_file="/storage/chenlab/Users/junwang/monkey/data/retcap/trans_file_new1"
trans_file="/storage/chenlab/Users/junwang/monkey/data/retcap/trans_file_new2_rm8"

with open(trans_file,"w") as tf:
	tf.write(f'transition: {transition}\n')
	tf.write(f'transversion: {transversion}\n')
	total=transition+transversion
	tf.write(f'total: {total}\n')

uniq_var=0
multi_var=0
for pos in multi_allele:
	if multi_allele[pos]==1:
		uniq_var+=1
	else:
		multi_var+=1
var_file="/storage/chenlab/Users/junwang/monkey/data/retcap/uniq_file_new2_rm8"

#var_file="/storage/chenlab/Users/junwang/monkey/data/retcap/uniq_file_new1"
ot1=open(var_file,"w")
ot1.write(f'uniq_var:\t{uniq_var}\n')
ot1.write(f'multi_var:\t{multi_var}\n')

#genotype_file="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_variant_geno_table_retcap_new1"
genotype_file="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_variant_geno_table_retcap_new2_rm8"

#genotype_file="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_variant_geno_table_retcap"
het_hom={}
het_hom["hom"]={}
het_hom["het"]={}
with open(genotype_file,'r') as gf:
	next(gf)
	for line in gf:
		info=line.split()
		tmp_info=info[3].replace("|",":").replace("/",":")
		genotype_info=tmp_info.split(':')
		nt=info[1].split(':')
		ref=nt[2]
		alt=nt[3]	
		pos=info[1] #f'{nt[0]}:{nt[1]}'
		if genotype_info[0]==genotype_info[1]:
			if pos not in het_hom["hom"]:
				het_hom["hom"][pos]={}
				het_hom["hom"][pos][info[2]]=1
			else:
				het_hom["hom"][pos][info[2]]=1
		else:
			if pos not in het_hom["het"]:
				het_hom["het"][pos]={}
				het_hom["het"][pos][info[2]]=1
			else:
				het_hom["het"][pos][info[2]]=1

		if info[1] in genotype:
			if genotype_info[0]==genotype_info[1]:
				genotype[info[1]][info[2]]=f'{alt}\t{alt}'
#				if pos not in het_hom["hom"]:
#					het_hom["hom"][pos]={}
#					het_hom["hom"][pos][info[2]]=1
#				else:
#					het_hom["hom"][pos][info[2]]=1
			else:
				if genotype_info[0]!=genotype_info[1]:
					genotype[info[1]][info[2]]=f'{ref}\t{alt}'
#				if pos not in het_hom["het"]:
#					het_hom["het"][pos]={}
#					het_hom["het"][pos][info[2]]=1
#				else:
#					het_hom["het"][pos][info[2]]=1

#ped_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.005.ped"
#ped_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF_AC2.ped"
#output="/storage/chenlab/Users/junwang/monkey/data/retcap/het_hom"
#output="/storage/chenlab/Users/junwang/monkey/data/retcap/het_hom_new1"
output="/storage/chenlab/Users/junwang/monkey/data/retcap/het_hom_new2_rm8"

ot=open(output,"w")
num_het=len(het_hom["het"].keys())
num_hom=len(het_hom["hom"].keys())
total_het=0
total_hom=0
for pos in het_hom["hom"]:
	total_hom += len(het_hom["hom"][pos].keys())

for pos in het_hom["het"]:
	total_het += len(het_hom["het"][pos].keys())

ot.write(f'het_var:\t{num_het}\n')
ot.write(f'hom_var:\t{num_hom}\n')
ot.write(f'total_het:\t{total_het}\n')
ot.write(f'total_hom:\t{total_hom}\n')
ot.close()

#ped_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2.ped"
#ped_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2_new1.ped"
ped_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2_new2_rm8.ped"

#ped_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.01.ped"
with open(ped_file, 'w') as pf:
	for mk in  monkey_list:
		pf.write(f'{mk}\t{mk}\t0\t0\t0\t1\t')
		for chrom in sorted(genotype_order.keys()):
			for pos in sorted(genotype_order[chrom].keys()):
				variant = genotype_order[chrom][pos]
				gf_tmp = genotype[variant][mk]
				pf.write(f'{gf_tmp}\t')
		
		pf.write("\n")

#map_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.005.map"
#map_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF_AC2.map"
#map_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2.map"
#map_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2_new1.map"
map_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2_new2_rm8.map"

#map_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.01.map"
with open(map_file, 'w') as mf:
	for chrom in sorted(genotype_order.keys()):
		for pos in sorted(genotype_order[chrom].keys()):
			variant = genotype_order[chrom][pos]
			var=variant.replace(":","_")
			mf.write(f'{chrom}\t{var}\t0\t{pos}\n')

			

