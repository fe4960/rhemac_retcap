import re
#monkey_table="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_corrected_updated"
monkey_table="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_new2_corrected_target_updated"
#monkey_table="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_new1_rm8_corrected_target_updated"

monkey_id={}
monkey_id["uccap"]={}
monkey_id["retcap"]={}
monkey_id_check={}
monkey_id_check["uccap"]={}
monkey_id_check["retcap"]={}
monkey_num={}
monkey_animial_id={}
monkey_animial_id["uccap"]={}
monkey_animial_id["retcap"]={}

#Index_ID        monkeyID        colonyID        monkey_internal_ID
#426     SNPRC_16346     SNPRC   36018
n=0
with open(monkey_table,"r") as mt:
	next(mt)
	for line in mt:
		line1=line.rstrip()
		info=line1.split()
		monkeyID=info[1].split("_")
		if monkeyID[1] == info[-1]:
			#n+=1 #print(info[-1])
			monkey_id["uccap"][info[-1]]=line1
			monkey_id_check["uccap"][info[1]]=line1
			monkey_animial_id["uccap"][info[-1]]=info[1]

		else:
			monkey_id["retcap"][info[-1]]=line1
			monkey_id_check["retcap"][info[1]]=line1
			monkey_animial_id["retcap"][info[-1]]=info[1]


#output="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_coverage_new1"
output="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_coverage_new2"

#output="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_coverage"
ot=open(output,"w")
retcap="/storage/chen/home/jw29/monkey/data/vcf_dir/retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget.stats"
flag=0
with open(retcap,"r") as rt:
	for line in rt:
		if re.search("^PSC", line): 
#PSC	0	11414-01b	369165	18088	41141	44784	14445	0	27.2	437
			info=line.split()
			if info[2] in monkey_id["retcap"]:
				if monkey_animial_id["retcap"][info[2]] not in monkey_num:
					monkey_num[monkey_animial_id["retcap"][info[2]]]={}
					monkey_num[monkey_animial_id["retcap"][info[2]]]["count"]=1
					monkey_num[monkey_animial_id["retcap"][info[2]]]["type"]={}
					monkey_num[monkey_animial_id["retcap"][info[2]]]["type"]["retcap"]=1
				else:
					monkey_num[monkey_animial_id["retcap"][info[2]]]["count"]+=1
					monkey_num[monkey_animial_id["retcap"][info[2]]]["type"]["retcap"]=1
				ot.write(f'{monkey_id["retcap"][info[2]]}\t{info[-2]}\n')	

UC_cap="/storage/chen/home/jw29/monkey/data/forDistribution_1-2UC/ucdavis.1-2.retinal.snps.stats"
flag=0
n=0
with open(UC_cap,"r") as rt:
	for line in rt:
		if re.search("^PSC",line):
			info=line.split()
			info1=info[2].split("_")
			n+=1
			#print(info1[0])
			if info1[0] in monkey_id["uccap"]:
				if monkey_animial_id["uccap"][info1[0]] not in monkey_num:
					monkey_num[monkey_animial_id["uccap"][info1[0]]]={}
					monkey_num[monkey_animial_id["uccap"][info1[0]]]["count"]=1
					monkey_num[monkey_animial_id["uccap"][info1[0]]]["type"]={}
					monkey_num[monkey_animial_id["uccap"][info1[0]]]["type"]["uccap"]=1
	
				else:
					monkey_num[monkey_animial_id["uccap"][info1[0]]]["count"]+=1
					monkey_num[monkey_animial_id["uccap"][info1[0]]]["type"]["uccap"]=1
#				n+=1
				ot.write(f'{monkey_id["uccap"][info1[0]]}\t{info[-2]}\n')	

new_cap="/storage/chen/home/jw29/monkey/data/retcap/genotypeGVCFs.2/output.filtered.snps.removed.vep.stats"
flag=0
n=0
with open(new_cap,"r") as rt:
	for line in rt:
		if re.search("^PSC",line):
			info=line.split()
			info1=info[2].split("_")
			n+=1
                        #print(info1[0])
			if info1[1] in monkey_id["uccap"]:
				if monkey_animial_id["uccap"][info1[1]] not in monkey_num:
					monkey_num[monkey_animial_id["uccap"][info1[1]]]={}
					monkey_num[monkey_animial_id["uccap"][info1[1]]]["count"]=1
					monkey_num[monkey_animial_id["uccap"][info1[1]]]["type"]={}
					monkey_num[monkey_animial_id["uccap"][info1[1]]]["type"]["newcap"]=1
				else:
					monkey_num[monkey_animial_id["uccap"][info1[1]]]["count"]+=1
					monkey_num[monkey_animial_id["uccap"][info1[1]]]["type"]["newcap"]=1
#                               n+=1
				ot.write(f'{monkey_id["uccap"][info1[1]]}\t{info[-5]}\n')

ot.close

#output1="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_check_new1"
output1="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_check_new2"

#output1="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_check"
ot1=open(output1,"w")
for monkeyid in monkey_id_check["uccap"]:
	if monkeyid in monkey_id_check["retcap"]:
		ot1.write(f'{monkeyid}\n')
ot1.close()
output2="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_check_num_new2"

#output2="/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_check_num_new1"
with open(output2, "w") as ot2:
	for key in monkey_num:
		if monkey_num[key]["count"] >1:
			type_line=monkey_num[key]["type"].keys()
			ot2.write(f'{key}\t{monkey_num[key]["count"]}\t{type_line}\n')
ot2.close()
		
