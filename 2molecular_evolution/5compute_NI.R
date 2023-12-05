library(qvalue)
#data=read.table("/storage/chenlab/Users/junwang/monkey/data/retnet/hm_rm_retnet_pair_MK",sep="\t")
#data=read.table("/storage/chenlab/Users/junwang/monkey/data/retnet/hm_rm_retnet_pair_MK_gnomad",sep="\t")
data=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair_MK_gnomad_AF",sep="\t")
#data=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair_MK_gnomad_AF0.01",sep="\t")

#SDCCAG8 ENST00000366541 ENSMMUT00000069525      41      39      54      36
#{N}\t{S}\t{PN}\t{PS}
fisher_test=function(l){
print(c(l[1], l[2], l[3], l[4]))
TeaTasting <-
matrix(c(l[1], l[2], l[3], l[4]),
       nrow = 2,
       dimnames = list(Guess = c("Milk", "Tea"),
                       Truth = c("Milk", "Tea")))
pval=fisher.test(TeaTasting)$p.value
return(pval)
}

data$pval=apply(data[,c(4:7)],1,fisher_test)
data$FN_FS=data[,4]/data[,5]
data$PN_PS=data[,6]/data[,7]
data$NI=data$PN_PS/data$FN_FS
data$qval=qvalue(data$pval)$qvalues
write.table(data,"/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair_MK_gnomad_AF_test",sep="\t",quote=F)
#write.table(data,"/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair_MK_gnomad_AF0.01_test",sep="\t",quote=F)

#write.table(data,"/storage/chenlab/Users/junwang/monkey/data/retnet/hm_rm_retnet_pair_MK_gnomad_test",sep="\t",quote=F)
#write.table(data,"/storage/chenlab/Users/junwang/monkey/data/retnet/hm_rm_retnet_pair_MK_test",sep="\t",quote=F)
