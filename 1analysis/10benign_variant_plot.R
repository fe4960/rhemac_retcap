library(ggplot2)
data=read.table("monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_extend_all",header=T,sep="\t")
#data$cadd=as.numeric(data$cadd)
mean(as.numeric(data[((( data$rhemac_AN >=200  )&(data$rhemac_AF>=0.21)&(data$rhemac_AF!=".")&( data$rhemac_AN !="."  ))|((data$gnomad_AF>=0.0123)&(data$gnomad_AF!=".")))&(data$cadd!="."),]$cadd))

length(as.numeric(data[(( ( data$rhemac_AN >=200  )&(data$rhemac_AF>=0.21)&(data$rhemac_AF!=".")&( data$rhemac_AN !="."  ))|((data$gnomad_AF>=0.0123) &(data$gnomad_AF!="."))  )&(data$cadd!="."),]$cadd))

benign=data[(( ( data$rhemac_AN >=200  )& (data$rhemac_AF>=0.21)&(data$rhemac_AF!=".")&( data$rhemac_AN !="."  ))|((data$gnomad_AF>=0.0123) &(data$gnomad_AF!=".")  )),]

write.table(benign,"monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_extend_all_benign",sep="\t",quote=F,row.names=F)

cadd=data[(( ( data$rhemac_AN >=200  )& (data$rhemac_AF>=0.21)&(data$rhemac_AF!=".")&( data$rhemac_AN !="."  ))|((data$gnomad_AF>=0.0123) &(data$gnomad_AF!=".")  ))&(data$cadd!="."),]
cadd$CADD=as.numeric(cadd$cadd)
pdf("monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_extend_all_cadd.pdf")
ggplot(data=cadd,aes(x=CADD))+geom_density()+theme_bw()+theme(text = element_text(size=30))+ylab("Density")
#theme(text = element_text(size=25),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(), panel.border=element_blank(),axis.line=element_line(colour="black"),legend.position="none")
dev.off()
length(cadd$CADD)
mean(cadd$CADD)

revel=data[(( ( data$rhemac_AN >=200  )&  (data$rhemac_AF>=0.21)&(data$rhemac_AF!=".")&( data$rhemac_AN !="."  )  )|((data$gnomad_AF>=0.0123)&(data$gnomad_AF!=".")))&(data$revel!="."),]
revel$REVEL=as.numeric(revel$revel)
pdf("monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_extend_all_revel.pdf")
ggplot(data=revel,aes(x=REVEL))+geom_density()+theme_bw()+theme(text = element_text(size=30))+ylab("Density")
#theme(text = element_text(size=25),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(), panel.border=element_blank(),axis.line=element_line(colour="black"),legend.position="none")
dev.off()
length(revel$REVEL)
mean(revel$REVEL)


AF=data[((  ( data$rhemac_AN >=200  )&   (data$rhemac_AF>=0.21)&(data$rhemac_AF!=".")&( data$rhemac_AN !="."  ))|((data$gnomad_AF>=0.0123)&(data$gnomad_AF!=".")   )  ),]
pdf("monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_extend_all_AF.pdf")
#ggplot(data=AF,aes(x=gnomad_AF))+geom_density()+theme(text = element_text(size=25),panel.background=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(), panel.border=element_blank(),axis.line=element_line(colour="black"),legend.position="none")
ggplot(data=AF,aes(x=gnomad_AF))+stat_ecdf()+theme_bw()+theme(text = element_text(size=30))+ylab("Cumulative distribution")
dev.off()
dim(AF)
