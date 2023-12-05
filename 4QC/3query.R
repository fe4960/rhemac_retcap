library(ggplot2)
data=read.table("/storage/chenlab/Users/junwang/monkey/data/database/retcap_genotypeGVCFs.3_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele.flt.GQ_DP_AB_new_query",header=T,sep="\t")
data$tech="batch3"
data1=read.table("/storage/chenlab/Users/junwang/monkey/data/database/retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_norm_ref_corrected.flt.GQ_DP_AB_new_query",header=T,sep="\t")
data1$tech="batch1"
data2=read.table("/storage/chenlab/Users/junwang/monkey/data/database/forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_norm_ref_corrected.flt.GQ_DP_AB_new_query",header=T,sep="\t")
data2$tech="batch2"
data_all=rbind(data,data1,data2)

data_all1=data_all[data_all$FILTER=="PASS",]

#tag=c("QUAL","BaseQRankSum","DP","FS", "InbreedingCoeff", "MQ", "QD","ReadPosRankSum",  "SOR")
tag=c("BaseQRankSum","FS", "InbreedingCoeff", "MQ", "QD","ReadPosRankSum",  "SOR")
for(t in tag){
file=paste0("/storage/chenlab/Users/junwang/monkey/data/database/retcap_tag_",t,".pdf")
pdf(file)
p=ggplot(data=data_all1,aes(x=as.numeric(data_all1[,t]),fill=data_all1$tech))+geom_histogram(bins=500,alpha=0.8)+theme(text=element_text(size=30),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),axis.line=element_line(color="black"))+ggtitle(t)+xlab(t)+labs(fill="")+scale_fill_brewer(palette="Set2")
print(p)
dev.off()
}

tag=c("QUAL")
for(t in tag){
file=paste0("/storage/chenlab/Users/junwang/monkey/data/database/retcap_tag_",t,".pdf")
pdf(file)
p=ggplot(data=data_all1,aes(x=log(as.numeric(data_all1[,t]),base=10),fill=data_all1$tech))+geom_histogram(bins=500,alpha=0.8)+theme(text=element_text(size=30),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),axis.line=element_line(color="black"))+ggtitle(t)+labs(fill="")+xlab(expression(paste(Log[10],'QUAL'))) +scale_fill_brewer(palette="Set2")

print(p)
dev.off()
}


tag=c("DP")
for(t in tag){
file=paste0("/storage/chenlab/Users/junwang/monkey/data/database/retcap_tag_",t,".pdf")
pdf(file)
p=ggplot(data=data_all1,aes(x=log(as.numeric(data_all1[,t]),base=10),fill=data_all1$tech))+geom_histogram(bins=500,alpha=0.8)+theme(text=element_text(size=30),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),axis.line=element_line(color="black"))+ggtitle(t)+labs(fill="")+xlab(expression(paste(Log[10],"DP")))+scale_fill_brewer(palette="Set2")
print(p)
dev.off()
}

file="/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8_clean"
data=read.table(file,header=T)
pdf("/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8_clean_AN.pdf")
ggplot(data=data,aes(x=log(as.numeric(data$AN),base=10)))+geom_histogram(bins=500)+theme(text=element_text(size=30),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),axis.line=element_line(color="black"))+ggtitle("AN")+labs(fill="")+xlab("AN")
dev.off()

pdf("/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8_clean_het_GF.pdf")
ggplot(data=data,aes(x=as.numeric(data$het_GF)))+geom_histogram(bins=500)+theme(text=element_text(size=30),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),axis.line=element_line(color="black"))+ggtitle("het_GF")+labs(fill="")+xlab("AN")
dev.off()
