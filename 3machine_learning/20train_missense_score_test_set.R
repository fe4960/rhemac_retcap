library(caret)
library(AUC)
library(cvAUC)
library(ggplot2)
library(gridExtra)

set.seed(1234567)

dir="/storage/chenlab/Users/junwang/monkey/data/retcap/"

setwd(dir)

data0=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_simple_score_extend_all",header=T,fill = TRUE)
#data0=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_simple_score_extend_all_flt",header=T,fill = TRUE)

data=data0[(data0$clinvar%in% c("Benign","Benign/Likely_benign","Likely_benign"))&(data0$rhemac_AN!=".")&((data0$rhemac_AN==0)| (data0$rhemac_AN>=200)),]

data1=data0[(data0$clinvar%in% c("Likely_pathogenic","Pathogenic","Pathogenic/Likely_pathogenic")) &(data0$rhemac_AN!=".")&((data0$rhemac_AN==0)| (data0$rhemac_AN>=200))  ,]

data$cadd=as.numeric(data$cadd)
data1$cadd=as.numeric(data1$cadd)

########current 15 score#####
#new_data=data.frame(sift=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$sift,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$sift)),rhemac_AF=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$rhemac_AF,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$rhemac_AF)),gnomad_AF=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$gnomad_AF,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$gnomad_AF)),cadd=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$cadd,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$cadd)),revel=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$revel,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$revel)),polyphen2=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$polyphen2,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$polyphen2)),mutationAssessor=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$mutationAssessor,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$mutationAssessor)),MetaSVM_score=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$MetaSVM_score,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$MetaSVM_score)),MetaLR_score=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$MetaLR_score,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$MetaLR_score)),phyloP100way_vertebrate=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$phyloP100way_vertebrate,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$phyloP100way_vertebrate)),phastCons100way_vertebrate=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$phastCons100way_vertebrate,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$phastCons100way_vertebrate)), VEST3=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$VEST3,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$VEST3)), DANN=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$DANN,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$DANN)),GERP=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$GERP,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$GERP)),Y=c(rep(0,dim(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",])[1]),rep(1,dim(data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",])[1])))
#new_data=na.omit(new_data)

#dim(new_data)

##########
iid_original=function(data,pre,res){

 
predictions=data[,pre] 

#ids.split <- split(sample(length(predictions)), rep(1:10, length = length(predictions)))

 
out1=cvAUC(predictions=predictions,labels=data$Y)
newlist=list("plotAUC"=out1)
return(newlist) 
}

iid_original1=function(data,pre,res){
 
predictions=1/data[,pre] 
 
out1=cvAUC(predictions=predictions,labels=data$Y)
newlist=list("plotAUC"=out1)
return(newlist) 
}


#########
 
 new_data=data.frame(rhemac_AF=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$rhemac_AF,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$rhemac_AF)),gnomad_AF=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$gnomad_AF,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$gnomad_AF)),cadd=c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$cadd,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$cadd),revel=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$revel,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$revel)),polyphen2=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$polyphen2,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$polyphen2)),mutationAssessor=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$mutationAssessor,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$mutationAssessor)),MetaSVM_score=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$MetaSVM_score,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$MetaSVM_score)),MetaLR_score=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$MetaLR_score,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$MetaLR_score)),phyloP100way_vertebrate=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$phyloP100way_vertebrate,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$phyloP100way_vertebrate)),phastCons100way_vertebrate=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$phastCons100way_vertebrate,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$phastCons100way_vertebrate)),VEST3=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$VEST3,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$VEST3)), DANN=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$DANN,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$DANN)),GERP=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$GERP,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$GERP)),Y=c(rep(0,dim(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",])[1]),rep(1,dim(data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",])[1])))
new_data=na.omit(new_data)

########
new_data_c=new_data
new_data_c[new_data_c$Y==1,]$Y="p"
new_data_c[new_data_c$Y==0,]$Y="b"

set.seed(1234567)

fitControl = trainControl(
 method = "repeatedcv",
 repeats=5,
 number=5,
 savePredictions ='final',
 classProbs = T,
 summaryFunction=twoClassSummary
 )


preproc = preProcess(new_data_c[,1:13],method = c("center", "scale"))
new_data_c_st=predict(preproc,new_data_c[,1:13])

# model_rf = train(new_data_c_st,new_data_c[,14],method="rf", trControl=fitControl,tuneLength=7, metric="ROC") #,preProcess = c('center','scale'))
 model_rf = train(new_data_c_st,new_data_c[,14],method="rf", trControl=fitControl,tuneLength=7, metric="ROC") #,preProcess = c('center','scale'))

model_rf

#########
data0=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_swiss_simple_score_extend_all",header=T,fill = TRUE)
#data0=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_simple_score_extend_all_flt",header=T,fill = TRUE)
data0=data0[!(data0$rhemac_coor%in%new_data_c$rhemac_coor),]


data=data0[(data0$clinvar=="LB/B")&(data0$rhemac_AN!=".")&((data0$rhemac_AN==0)| (data0$rhemac_AN>=200)),]

data1=data0[(data0$clinvar=="LP/P") &(data0$rhemac_AN!=".")&((data0$rhemac_AN==0)| (data0$rhemac_AN>=200))  ,]

data$cadd=as.numeric(data$cadd)
data1$cadd=as.numeric(data1$cadd)

########current 15 score#####
new_data_swiss=data.frame(rhemac_AF=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$rhemac_AF,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$rhemac_AF)),gnomad_AF=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$gnomad_AF,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$gnomad_AF)),cadd=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$cadd,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$cadd)),revel=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$revel,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$revel)),polyphen2=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$polyphen2,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$polyphen2)),mutationAssessor=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$mutationAssessor,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$mutationAssessor)),MetaSVM_score=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$MetaSVM_score,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$MetaSVM_score)),MetaLR_score=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$MetaLR_score,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$MetaLR_score)),phyloP100way_vertebrate=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$phyloP100way_vertebrate,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$phyloP100way_vertebrate)),phastCons100way_vertebrate=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$phastCons100way_vertebrate,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$phastCons100way_vertebrate)), VEST3=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$VEST3,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$VEST3)), DANN=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$DANN,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$DANN)),GERP=as.numeric(c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$GERP,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$GERP)),Y=c(rep(0,dim(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",])[1]),rep(1,dim(data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",])[1])), rhemac_coor=c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$rhemac_coor,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$rhemac_coor),hg19_coor=c(data[data$rhemac_var=="missense_variant"&data$hg_var=="nonsynonymous_SNV",]$hg19_coor,data1[data1$rhemac_var=="missense_variant"&data1$hg_var=="nonsynonymous_SNV",]$hg19_coor) )
new_data_swiss$rhemac_coor=gsub("chr","",new_data_swiss$rhemac_coor)
new_data_swiss=na.omit(new_data_swiss)

dim(new_data_swiss)

#new_data_swiss_pre=preProcess(new_data_swiss[,1:13],method=c("center","scale"))
new_data_swiss_st=predict(preproc,new_data_swiss[,1:13])

# new_data_swiss$rf=predict(model_rf,new_data_swiss[,1:13],type='prob')[,2]
 new_data_swiss$rf=predict(model_rf,new_data_swiss_st,type='prob')[,2]


############
out_rhemac_af=iid_original1(data=new_data_swiss,pre="rhemac_AF" ,res="Y")
out_gnomad_af=iid_original1(data=new_data_swiss,pre="gnomad_AF" ,res="Y")
out_cadd=iid_original(data=new_data_swiss,pre="cadd" ,res="Y")
out_revel=iid_original(data=new_data_swiss,pre="revel" ,res="Y")
#out_sift=iid_original(data=new_data,pre="sift" ,res="Y")
out_polyphen2=iid_original(data=new_data_swiss,pre="polyphen2" ,res="Y")
#out_sift=iid_original(data=new_data_swiss,pre="sift" ,res="Y")

out_mutationAssessor=iid_original(data=new_data_swiss,pre="mutationAssessor" ,res="Y")
out_MetaSVM_score=iid_original(data=new_data_swiss,pre="MetaSVM_score" ,res="Y")
out_MetaLR_score=iid_original(data=new_data_swiss,pre="MetaLR_score" ,res="Y")
out_phyloP100way_vertebrate=iid_original(data=new_data_swiss,pre="phyloP100way_vertebrate" ,res="Y")
#out_phyloP20way_mammalian=iid_original(data=new_data_swiss,pre="phyloP20way_mammalian" ,res="Y")
out_phastCons100way_vertebrate=iid_original(data=new_data_swiss,pre="phastCons100way_vertebrate" ,res="Y")
#out_phastCons20way_mammalian=iid_original(data=new_data_swiss,pre="phastCons20way_mammalian" ,res="Y")
out_VEST3=iid_original(data=new_data_swiss,pre="VEST3" ,res="Y")
out_DANN=iid_original(data=new_data_swiss,pre="DANN" ,res="Y")
out_GERP=iid_original(data=new_data_swiss,pre="GERP" ,res="Y")
out_rf=iid_original(data=new_data_swiss,pre="rf" ,res="Y")

########
pdf("AUC_all_13score_swiss_missense_target_new_rm8_more.pdf")
par(mar = c(4, 6, 2, 2))

#######here need to change the number of pathogenic alleles XXXX and benign alleles XXX to the corresponding value
# plot(out_rhemac_hom$plotAUC$perf,col="black",main=paste0("AUC (patho ", dim(new_data[new_data$Y==1,])[1]," vs. benign ", dim(new_data[new_data$Y==0,])[1], " )"),lwd=2)
plot(x=0,y=0,col="white",lwd=2,xlim=c(0,1),ylim=c(0,1),ylab="TP rate", xlab="FP rate",cex.lab=2.5, cex.axis=2.5)
# plot(out_rhemac_hom$plotAUC$perf,col="",avg="vertical",add=TRUE,lwd=2)
plot(out_rhemac_af$plotAUC$perf,col="black",avg="vertical",add=TRUE,lwd=2)
plot(out_gnomad_af$plotAUC$perf,col="red",avg="vertical",add=TRUE,lwd=2)
plot(out_cadd$plotAUC$perf,col="blue",avg="vertical",add=TRUE,lwd=2)
plot(out_revel$plotAUC$perf,col="olivedrab",avg="vertical",add=TRUE,lwd=2)
#plot(out_sift$plotAUC$perf,col="violet",avg="vertical",add=TRUE,lwd=2)
plot(out_polyphen2$plotAUC$perf,col="mediumturquoise",avg="vertical",add=TRUE,lwd=2)
plot(out_mutationAssessor$plotAUC$perf,col="grey",avg="vertical",add=TRUE,lwd=2)
plot(out_MetaSVM_score$plotAUC$perf,col="green",avg="vertical",add=TRUE,lwd=2)
plot(out_MetaLR_score$plotAUC$perf,col="pink",avg="vertical",add=TRUE,lwd=2)
plot(out_phyloP100way_vertebrate$plotAUC$perf,col="yellow",avg="vertical",add=TRUE,lwd=2)
#plot(out_phyloP20way_mammalian$plotAUC$perf,col="purple",avg="vertical",add=TRUE,lwd=2)
plot(out_phastCons100way_vertebrate$plotAUC$perf,col="lightgreen",avg="vertical",add=TRUE,lwd=2)
#plot(out_phastCons20way_mammalian$plotAUC$perf,col="gold",avg="vertical",add=TRUE,lwd=2)
plot(out_VEST3$plotAUC$perf,col="lightblue",avg="vertical",add=TRUE,lwd=2)
plot(out_DANN$plotAUC$perf,col="lightpink",avg="vertical",add=TRUE,lwd=2)
plot(out_GERP$plotAUC$perf,col="thistle",avg="vertical",add=TRUE,lwd=2)
plot(out_rf$plotAUC$perf,col="purple",avg="vertical",add=TRUE,lwd=2)

########## paste the AUC value onto the same plot
#n1=paste("rhemac_hom (AUC= ",round(out_rhemac_hom$plotAUC$cvAUC,3),")",sep="")
n2=paste("rhemac_af (AUC= ",round(out_rhemac_af$plotAUC$cvAUC,3),")",sep="")
n3=paste("gnomad_af (AUC= ",round(out_gnomad_af$plotAUC$cvAUC,3),")",sep="")
n4=paste("CADD (AUC= ",round(out_cadd$plotAUC$cvAUC,3),")",sep="")
n5=paste("REVEL (AUC= ",round(out_revel$plotAUC$cvAUC,3),")",sep="")
#n6=paste("SIFT (AUC= ",round(out_sift$plotAUC$cvAUC,3),")",sep="")
n7=paste("polyphen2 (AUC= ",round(out_polyphen2$plotAUC$cvAUC,3),")",sep="")
n8=paste("mutationAssessor (AUC= ",round(out_mutationAssessor$plotAUC$cvAUC,3),")",sep="")
n9=paste("MetaSVM_score (AUC= ",round(out_MetaSVM_score$plotAUC$cvAUC,3),")",sep="")
n10=paste("MetaLR_score (AUC= ",round(out_MetaLR_score$plotAUC$cvAUC,3),")",sep="")
n11=paste("phyloP100way_vertebrate (AUC= ",round(out_phyloP100way_vertebrate$plotAUC$cvAUC,3),")",sep="")
#n12=paste("phyloP20way_mammalian (AUC= ",round(out_phyloP20way_mammalian$plotAUC$cvAUC,3),")",sep="")
n13=paste("phastCons100way_vertebrate (AUC= ",round(out_phastCons100way_vertebrate$plotAUC$cvAUC,3),")",sep="")
#n14=paste("phastCons20way_mammalian (AUC= ",round(out_phastCons20way_mammalian$plotAUC$cvAUC,3),")",sep="")

n19=paste("VEST3 (AUC= ",round(out_VEST3$plotAUC$cvAUC,3),")",sep="")
n21=paste("DANN (AUC= ",round(out_DANN$plotAUC$cvAUC,3),")",sep="")
n22=paste("GERP (AUC= ",round(out_GERP$plotAUC$cvAUC,3),")",sep="")
n23=paste("HM (AUC= ",round(out_rf$plotAUC$cvAUC,3),")",sep="")

legend("bottomright",c(n2,n3,n4,n5,n7,n8,n9,n10,n11,n13,n19,n21,n22, n23),lty=1,col=c("black","red","blue","olivedrab","mediumturquoise","grey","green","pink", "yellow","lightgreen",  "lightblue","lightpink","thistle","purple"),inset=0.05,lwd=2)


#legend("bottomright",c(n2,n3,n4,n5,n7,n8,n9,n10,n11,n12,n13,n14,n19,n21,n22),lty=1,col=c("black","red","blue","olivedrab","mediumturquoise","grey","green","pink","yellow","purple","lightgreen","gold","lightblue","lightpink","thistle"),inset=0.05,lwd=2)
dev.off()

write.table(new_data_swiss,file="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_swiss_simple_score_extend_all_rf",sep="\t",quote=F,row.names=F)

data_all=read.table("/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_extend_all",header=T)
data_all=data_all[(data_all$rhemac_AN!=".")&((data_all$rhemac_AN==0)| (data_all$rhemac_AN>=200)),]
new_data_all=data.frame(rhemac_AF=data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$rhemac_AF,gnomad_AF=data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$gnomad_AF,cadd=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$cadd),revel=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$revel),polyphen2=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$polyphen2),mutationAssessor=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$mutationAssessor),MetaSVM_score=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$MetaSVM_score),MetaLR_score=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$MetaLR_score),phyloP100way_vertebrate=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$phyloP100way_vertebrate),phastCons100way_vertebrate=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$phastCons100way_vertebrate),VEST3=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$VEST3), DANN=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$DANN),GERP=as.numeric(data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$GERP),rhemac_coor=data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$rhemac_coor,hg19_coor=data_all[data_all$rhemac_var=="missense_variant"&data_all$hg_var=="nonsynonymous_SNV",]$hg19_coor)
new_data_all=na.omit(new_data_all)

library(ComplexHeatmap)

cor=cor(new_data_all[,c(1:13)])
pdf("/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_simple_score_extend_all_cor.pdf",width=8)
diag(cor)=NA
Heatmap(cor)
dev.off()

new_data_all_st=predict(preproc,new_data_all[,1:13])
new_data_all$rf=predict(model_rf,new_data_all_st,type='prob')[,2]


opa1=new_data_all[new_data_all$rhemac_coor=="2:4364931:C:A",]$rf
#[1] 0.746
print(opa1)
qu=quantile(new_data_all$rf,seq(0,1,0.05))
print(qu[20])
pdf("/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_rf_13score.pdf")
#ggplot(data=new_data_all,aes(x=rf))+geom_density(size=1)+theme(text=element_text(size=28),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),axis.line=element_line(color="black"))+xlab("Random forest score")+xlim(0,1.05)

ggplot(data=new_data_all,aes(x=rf))+geom_density(size=1)+theme_bw()+theme(text=element_text(size=28))+xlab("HM score")+xlim(0,1.05)+geom_vline(xintercept=qu[20],color="red")+ylab("Density")

dev.off()
write.table(new_data_all,file="/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_rf13",sep="\t",quote=F, row.names=F)




new_data_swiss_all=unique(rbind(new_data_swiss[,c("rhemac_coor","revel","cadd","polyphen2","rf")],new_data_all[,c("rhemac_coor","revel","cadd","polyphen2","rf")]))

new_data_swiss_all$revel_rank=rank(new_data_swiss_all$revel)/length(new_data_swiss_all$revel)
new_data_swiss_all$cadd_rank=rank(new_data_swiss_all$cadd)/length(new_data_swiss_all$cadd)
new_data_swiss_all$rf_rank=rank(new_data_swiss_all$rf)/length(new_data_swiss_all$rf)

data1=new_data_swiss_all[new_data_swiss_all$rhemac_coor%in%new_data_swiss[new_data_swiss$Y==1,]$rhemac_coor,]
mean(data1$revel_rank)
#[1] 0.8382406
mean(data1$cadd_rank)
#[1] 0.7653036
mean(data1$rf_rank)
#[1] 0.8224664

data2=data.frame(var=rep(data1$rhemac_coor,3),score_type=c(rep("HM",length(data1$rhemac_coor)), rep("CADD",length(data1$rhemac_coor)),rep("REVEL",length(data1$rhemac_coor))),score=c(data1$rf_rank, data1$cadd_rank, data1$revel_rank))

library(ggplot2)
pdf("/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_swiss_simple_score_extend_all_rf_ranking.pdf")
ggplot(data=data2, aes(x=score,color=score_type))+stat_ecdf(geom="point")+theme_bw()+theme(text=element_text(size=30))
dev.off()

write.table(data1,file="/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_swiss_simple_score_extend_all_rf_rank",sep="\t",quote=F,row.names=F)
