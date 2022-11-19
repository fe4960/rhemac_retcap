#mds_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.1.mds"
#mds_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.01.mds"
#mds_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF0.005.mds"
#mds_file="/storage/chenlab/Users/junwang/monkey/data/retnet/retnet_overlap_AF_AC2.mds"
#mds_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2.mds"
#mds_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2_new1.mds"
mds_file="/storage/chenlab/Users/junwang/monkey/data/retcap/retcap_AC2_new2_rm8.mds"

with open(mds_file,'r') as mf:
	line=next(mf).rstrip()
	output=f'{mds_file}_colony'
	with open(output, 'w') as ot:
		ot.write(f'{line}\tcolony\n')
		for line in mf:
			info=line.split()
			name=info[1].split("_")
			newline=line.rstrip()
			ot.write(f'{newline}\t{name[0]}\n')

