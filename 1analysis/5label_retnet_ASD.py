#target_gene="/storage/chen/home/jw29/monkey/data/target_gene_final_edit"
target_gene="/storage/chenlab/Users/junwang/monkey/data/retcap/panel.100416.liftover.design.txt_gene_final"
target_gene_dict={}
with open(target_gene,"r") as tg:
	for line in tg:
		line1=line.rstrip()
		target_gene_dict[line1]=1

autism_gene="/storage/chen/home/jw29/monkey/data/Autism_gene"
autism_gene_dict={}
with open(autism_gene,"r") as asd:
	for line in asd:
		line1=line.rstrip()
		autism_gene_dict[line1]=1
output_var_target="monkey/data/retcap/target_gene_with_var_new2_rm8"

#output_var_target="monkey/data/retcap/target_gene_with_var_new1"
op=open(output_var_target,"w")

#var_gene="monkey/data/retcap/monkey_gene_table_vep101_genename_filtered_retcap_updated_gene"
#var_gene="/storage/chenlab/Users/junwang/monkey/data/retcap/panel.100416.liftover.design.txt_gene_final"
#var_gene="monkey/data/retcap/variant_table_retcap_corrected_vep101_target_updated_gene"
#var_gene="monkey/data/retcap/variant_table_retcap_new1_corrected_vep101_target_updated_gene"
var_gene="monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gene"

with open(var_gene, "r") as vg:
	for line in vg:
		line1=line.rstrip()

		if line1 in target_gene_dict:
			if line1 in autism_gene_dict:
				op.write(f'{line1}\tASD\n')
			else:
				op.write(f'{line1}\tIRD\n')
op.close()
				

