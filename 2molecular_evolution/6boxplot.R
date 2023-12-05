library(qvalue)
library(ggplot2)

data=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair_kaks_codeml_gene")
pdf("/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair_kaks_codeml_gene_box.pdf")


#data=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair_MK_gnomad_AF_test_gene",sep="\t",header=T)
#pdf("/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair_MK_gnomad_AF_test_gene_box.pdf")
ggplot(data=data,aes(x=V16,fill=V16,y=V9))+geom_boxplot()+theme(text = element_text(size=30),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(), panel.border=element_blank(),axis.line=element_line(colour="black"),legend.position="none")+xlab("")+ylab("dN/dS")+scale_fill_brewer(palette = "Set3")
dev.off()

 wilcox.test(data[data$V16=="IRD",]$V9,data[data$V16=="ND",]$V9,alternative="greater")$p.value


