#!/usr/bin/perl -w
#use strict;
my $dir="/storage/chenlab/Users/junwang";
my $main = "$dir/monkey/data/database";
#######read monkey variant
#my @file=("genotypeGVCFs.7_onTarget_output.filtered.indels.removed.vep.sorted_gatkfiltered.vcf.gz.splitMuliallele", "genotypeGVCFs.7_onTarget_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");
######my @file=("genotypeGVCFs.8_output.filtered.indels.removed.vep.sorted_gatkfiltered.vcf.gz.splitMuliallele", "genotypeGVCFs.8_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");


#my @file=("genotypeGVCFs.9_output.filtered.indels.removed.vep.sorted.fix_gatkfiltered.vcf.gz.splitMuliallele", "genotypeGVCFs.9_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");

#my @file=("genotypeGVCFs.10_output.filtered.indels.removed.vep.no.isoseq.sorted.fix_gatkfiltered.vcf.gz.splitMuliallele", "genotypeGVCFs.10_output.filtered.snps.removed.vep.no.isoseq_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");

my %keep_monkey;
my $rm_monkey = "/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_seq_coverage_new2_add";
open(INPUTrm,$rm_monkey);
while(my $linerm = <INPUTrm>){
chomp $linerm;
my @info = split(/\s+/,$linerm);
if($info[-1] >=10){
$keep_monkey{$info[1]}=1;
#print "$info[1]\t$info[-1]\n";
}
}



my @file=("retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");

#my @file = ("es1");

my @seq = ("UC_Capture2022","UC_Capture","Capture");
my @tail = ("","_rheMac10","_rheMac10");
my @var_prefix = ("rheMac10","rheMac8","rheMac8");
#####read cap monkey info
my $retcap_id = "$dir/monkey/data/database/retcap_colony_animal_ID";
my %colony;
my %hash;
open(INPUT,$retcap_id);
while(my $line = <INPUT>){
chomp $line;
my @info = split(/\s+/,$line);
$cap{$info[1]}->{anim_ID}=$info[2];
$cap{$info[1]}->{col}=$info[0];
}
######
my %rhemac10_rhemac8;
########read WES rhemac10 to hg19#########
my %rhemac10_hg19;
my %internal_ID;
#my @WES_hg19=("monkey/data/database/genotypeGVCFs.7_onTarget_output.filtered.indels.removed.vep.sorted_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref","monkey/data/database/genotypeGVCFs.7_onTarget_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref");
####my @WES_hg19=("monkey/data/database/genotypeGVCFs.8_output.filtered.indels.removed.vep.sorted_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref","monkey/data/databas/genotypeGVCFs.8_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref");


#my @WES_hg19=("$dir/monkey/data/database/genotypeGVCFs.9_output.filtered.indels.removed.vep.sorted.fix_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref","$dir/monkey/data/database/genotypeGVCFs.9_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref");

#my @WES_hg19=("$dir/monkey/data/database/genotypeGVCFs.10_output.filtered.indels.removed.vep.no.isoseq.sorted.fix_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref","$dir/monkey/data/database/genotypeGVCFs.10_output.filtered.snps.removed.vep.no.isoseq_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref");
my @WES_hg19=("$dir/monkey/data/database/retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele_hg19AF_w_header_norm_ref");


for my $WES_hg19 (@WES_hg19){
open(INPUT1,$WES_hg19);
while(my $line1 = <INPUT1>){
if($line1 =~ /^#/){
next;
}
my @info1 = split(/\s+/,$line1);
my @info2 = split(/\:/,$info1[2]);
my $hg19_id = "$info1[0]:$info1[1]:$info1[3]:$info1[4]";
$hg19_id =~ s/chr//g;
my $rhemac10_id = join(":",@info2[0..3]);
$rhemac10_hg19{$rhemac10_id} = $hg19_id;
}
}
########read capture rhemac8 to hg19#########
my %rhemac8_hg19;
#my @capture_hg19 = ("forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");
my @capture_hg19 = ("forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele",  "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");

for my $capture_hg19 (@capture_hg19){
my $capture_hg19_new="$main/$capture_hg19"."_rheMac10_hg19AF_w_header_norm_ref";
open(INPUT1,$capture_hg19_new);
while(my $line1 = <INPUT1>){
if($line1 =~ /^#/){
next;
}
#1       222002348       chr1:1462395:T:C 
#chr1    2337163 chr1:1462393:T:C|1:222002350:A:G:
my @info1 = split(/\s+/,$line1);
my @info2 = split(/\|/,$info1[2]);
$rhemac8_id = $info2[0];
$rhemac8_id =~ s/chr//g;
$hg19_id = "$info1[0]:$info1[1]:$info1[3]:$info1[4]";
$hg19_id =~ s/chr//g;
$rhemac8_hg19{$rhemac8_id} = $hg19_id;
}
}
##########read capture rhemac8 to rhemac10 ########
my %rhemac8_rhemac10;
#my @capture_rhemac10 = ("forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");

my @capture_rhemac10 = ("forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");

for my $capture_rhemac10 (@capture_rhemac10){
my $capture_rhemac10_new="$main/$capture_rhemac10"."_rheMac10_w_header_norm_ref";
open(INPUT1,$capture_rhemac10_new);
while(my $line1 = <INPUT1>){
if($line1 =~ /^#/){
next;
}

my @info1 = split(/\s+/,$line1);
#1       222001276       chr1:1463469:C:T 
my $rhemac10_id ="$info1[0]:$info1[1]:$info1[3]:$info1[4]";
my $rhemac8_id = $info1[2];
$rhemac10_id =~ s/chr//g;
$rhemac8_id =~ s/chr//g;
$rhemac8_rhemac10{$rhemac8_id} = $rhemac10_id;
}
}


#####read each file######
my %monkey_genotype;
my %monkey_ID;
my %var_hash;
my %gene_hash;

my %monkey_genotype_total;
my %monkey_genotype_AC;


for(my $i=0; $i<=$#file; $i++){
my $monkey_var = "$main/$file[$i]".".flt.GQ_DP_AB_new";

my $file_flag="snp";
if($file[$i] =~ /indel/){
$file_flag="indel";
}

open(INPUT,$monkey_var);
my %header=();
my @header;
while(my $line = <INPUT>){
if($line =~ /^#CHR/){
chomp $line;
@header = split(/\s+/,$line);
for(my $j=9; $j<=$#header; $j++){ ####read monkey
####read header
if($seq[$i] eq "UC_Capture2022"){
my @header1 = split(/_/,$header[$j]);
$header1[0] =~ s/WNPC/WNPRC/g;
my $monkey_ID = "$header1[0]"."_"."$header1[1]";
my $monkey_colony = "$header1[0]";
$monkey_ID{$monkey_ID}->{col}->{$monkey_colony}=1;
$monkey_ID{$monkey_ID}->{seq}->{UC_Capture2022}=1;
$header{$j}=$monkey_ID;
$internal_ID{$monkey_ID}=$header1[1];
}elsif($seq[$i] eq "UC_Capture"){
my $monkey_colony = "CNPRC";
my @header1 = split(/_/,$header[$j]);
my $monkey_ID = $monkey_colony."_"."$header1[0]";
$monkey_ID{$monkey_ID}->{col}->{$monkey_colony}=1;
$monkey_ID{$monkey_ID}->{seq}->{UC_Capture}=1;
$internal_ID{$monkey_ID}=$header1[0];

$header{$j}=$monkey_ID;
}elsif($seq[$i] eq "Capture"){
my $monkey_colony = $cap{$header[$j]}->{col};
my $monkey_ID;
if(!($monkey_colony)){
print "monkey_id:$header[$j]\n";
}
#if($monkey_colony =~ /Unknown/){
#next;
#}
$monkey_ID = $monkey_colony."_".$cap{$header[$j]}->{anim_ID};
#}
$monkey_ID{$monkey_ID}->{col}->{$monkey_colony}=1;
$header{$j}=$monkey_ID;
$monkey_ID{$monkey_ID}->{seq}->{Capture}=1;
$internal_ID{$monkey_ID}=$header[$j];
}
#######################
}
}elsif(($line !~ /^#/)&&($line =~ /^\S+/)&&($line !~ /^\n/)){
#}elsif(($line !~ /^#/)){
my @info = split(/\t/,$line);  
$info[0] =~ s/chr//g;
#####set var_id
#my $var_id;
#print "$line\n";
if($info[4] eq '*'){
next;
}
my $tmp_id = "$info[0]:$info[1]:$info[3]:$info[4]";
my $var_id = $tmp_id;

#if($var_id eq "7:16990133:T:G"){
#print  "fail:$line\t";
#print  "fail:$var_id\n";
#print  "file:$file[$i]\n";
#exit;
#}

if($var_prefix[$i] eq "rheMac8"){
if(!(defined $rhemac8_rhemac10{$tmp_id})){
next;
}else{
$var_id = $rhemac8_rhemac10{$tmp_id};
$rhemac10_rhemac8{$var_id} = $tmp_id;

}
}
if($info[6] ne "PASS"){
next;
}
my @var=split(/\;/,$info[7]);
if(!(defined $var[4])){
#print "$line\n";
}
for(my $v1=0; $v1<=$#var; $v1++){
if($var[$v1]=~/^CSQ=/){
#my @var1 = split(/\=/,$var[4]);
my @var1 = split(/\=/,$var[$v1]);
my @var2 = split(/\,/,$var1[1]);
for(my $v=0; $v<=$#var2; $v++){
my @var3 = split(/\|/,$var2[$v]);
#my $flag="snp";
#if((length($info[4])>1)||(length($info[3])>1)){
#$flag="indel";
#}

my $tmp_var = "$info[3]"."$var3[0]";
if($var3[0] eq "-"){
$tmp_var = $info[4];
}
#print "start\t$file_flag\t$info[4]\t$var3[0]\n";
if((($file_flag eq "indel")&&($info[4] eq $tmp_var))||( ($file_flag eq "snp")&&($info[4] eq $var3[0]) )){####read the first annotation of monkey
#print "enter\n";
if($var3[1] =~ /\S+/){
$var_hash{$var_id}->{monkey}->{variant_type} = "$var3[1]";
}else{
$var_hash{$var_id}->{monkey}->{variant_type} = ".";
}
if($var3[2] =~ /\S+/){
$var_hash{$var_id}->{monkey}->{variant_eff} = "$var3[2]";
}else{
$var_hash{$var_id}->{monkey}->{variant_eff} = ".";
}
if($var3[3]  =~ /\S+/){
$var_hash{$var_id}->{monkey}->{genename} = "$var3[3]";
}else{
$var_hash{$var_id}->{monkey}->{genename} = ".";
}

if($var3[4] =~ /\S+/){
 $var_hash{$var_id}->{monkey}->{ensembl_gene} = "$var3[4]";
}else{
$var_hash{$var_id}->{monkey}->{ensembl_gene} = ".";
}

if($var3[6]=~ /\S+/){
$var_hash{$var_id}->{monkey}->{ensembl_trans} = "$var3[6]";
}else{
$var_hash{$var_id}->{monkey}->{ensembl_trans} = ".";
}

if($var3[1] =~ /intron/){
if($var3[9]=~ /\S+/){
$var_hash{$var_id}->{monkey}->{exon} = "intron:$var3[9]";
}else{
$var_hash{$var_id}->{monkey}->{exon} = "intron:.";
}
}else{
if($var3[8]=~ /\S+/){
$var_hash{$var_id}->{monkey}->{exon} = "exon:$var3[8]";
}else{
$var_hash{$var_id}->{monkey}->{exon} = "exon:.";
}
}
if($var3[12] =~ /\S+/){
$var_hash{$var_id}->{monkey}->{cDNA_change} = "$var3[12]_$var3[16]";
}else{
$var_hash{$var_id}->{monkey}->{cDNA_change} =".";
}
if($var3[14] =~ /\S+/){
$var_hash{$var_id}->{monkey}->{aa_change} = "$var3[14]_$var3[15]";
}else{
$var_hash{$var_id}->{monkey}->{aa_change} = ".";
}
last;
}
}
###
last;
}
}
#######read genotype info
for(my $j=9; $j<=$#info; $j++){
if($info[$j] !~ /\S+/){
next;
}
if((defined $keep_monkey{$header{$j}}) && ($keep_monkey{$header{$j}}==1)){

if(($seq[$i] eq "Capture") && ($cap{$header[$j]}->{col} =~/Unknown/)){
next;
}


#if((defined $rm_monkey{$header{$j}}) && ($rm_monkey{$header{$j}}==1)){ ######remove the ones with low sequence coverage
#next;
#}


if((defined $monkey_genotype{$var_id}->{$header{$j}}->{seq}  ) && ($monkey_genotype{$var_id}->{$header{$j}}->{seq} =~  /UC_Capture2022/)){ #if it has already been defined.
next;
}elsif((defined $monkey_genotype{$var_id}->{$header{$j}}->{seq} )&&($monkey_genotype{$var_id}->{$header{$j}}->{seq} =~ /UC_Capture/)){ #if it has already been defined.
next;
}else{

#0/0:34,0:34:99:.:.:0,99,1233:.
my @info_gt = split(/\:/,$info[$j]);
my @info_gt_type =split(/\/|\|/,$info_gt[0]);
#print $line;
if(($info_gt_type[0] =~ /\n/)||($info_gt_type[1] =~ /\n/)){
print "$line:end\n";
exit;
}


my @colony = split(/\_/,$header{$j});

if(($info_gt[0] !~ /\.\/\./ )&&($info_gt_type[0] ne "\.")&&($info_gt_type[1] ne "\.")&&(($info_gt_type[0]!=0)||($info_gt_type[1] !=0))){


#if(($info_gt[0] !~ /\.\/\./ )&&($info_gt[0] ne "\.")&&($info_gt[1] ne "\.")&&(($info_gt_type[0]!=0)||($info_gt_type[1] !=0))){
$monkey_genotype{$var_id}->{$header{$j}}->{seq}=$seq[$i];
$monkey_genotype{$var_id}->{$header{$j}}->{gt_detail} = $info[$j];
if($info_gt_type[0] != $info_gt_type[1]){
$monkey_genotype{$var_id}->{$header{$j}}->{gt_simple} = "Het";
$monkey_AC{$var_id}->{$seq[$i]}->{AC}++;

$monkey_genotype_AC{$var_id}->{total}->{AC1}->{$header{$j}}=1;
$monkey_genotype_AC{$var_id}->{total}->{het}->{$header{$j}}=1;

$monkey_genotype_AC{$var_id}->{$colony[0]}->{AC1}->{$header{$j}}=1;
$monkey_genotype_AC{$var_id}->{$colony[0]}->{het}->{$header{$j}}=1;

$monkey_genotype_total{$var_id}->{total}->{$header{$j}}=1;
$monkey_genotype_total{$var_id}->{$colony[0]}->{$header{$j}}=1;


}else{
$monkey_genotype{$var_id}->{$header{$j}}->{gt_simple} = "Hom";
$monkey_AC{$var_id}->{$seq[$i]}->{AC}+=2;

$monkey_genotype_AC{$var_id}->{total}->{AC2}->{$header{$j}}=1;
$monkey_genotype_AC{$var_id}->{total}->{hom}->{$header{$j}}=1;

$monkey_genotype_AC{$var_id}->{$colony[0]}->{AC2}->{$header{$j}}=1;
$monkey_genotype_AC{$var_id}->{$colony[0]}->{hom}->{$header{$j}}=1;
$monkey_genotype_total{$var_id}->{total}->{$header{$j}}=1;
$monkey_genotype_total{$var_id}->{$colony[0]}->{$header{$j}}=1;


}
#}#elsif($info_gt[0] !~ /\.\/\./){
}elsif(($info_gt[0] !~ /\.\/\./ )&&($info_gt_type[0] ne "\.")&&($info_gt_type[1] ne "\.")){
$monkey_AC{$var_id}->{$seq[$i]}->{num}++;

$monkey_genotype_total{$var_id}->{total}->{$header{$j}}=1;
$monkey_genotype_total{$var_id}->{$colony[0]}->{$header{$j}}=1;

}
}
}
}
}

}
}
#####read human annotation#######
#my @human_anno = ("genotypeGVCFs.7_onTarget_output.filtered.indels.removed.vep.sorted_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","genotypeGVCFs.7_onTarget_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis");
#######my @human_anno = ("genotypeGVCFs.8_output.filtered.indels.removed.vep.sorted_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","genotypeGVCFs.8_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis");

#my @human_anno = ("genotypeGVCFs.9_output.filtered.indels.removed.vep.sorted.fix_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","genotypeGVCFs.9_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis");


#my @human_anno = ("genotypeGVCFs.10_output.filtered.indels.removed.vep.no.isoseq.sorted.fix_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","genotypeGVCFs.10_output.filtered.snps.removed.vep.no.isoseq_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis");

my @human_anno = ("retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele_hg19AF.format.sorted.analysis","forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis", "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele_rheMac10_hg19AF.format.sorted.analysis");

my %human_anno;
for my $human_anno (@human_anno){
my $human_anno_new = "$main/$human_anno";
open(INPUTh,"$human_anno_new");
my $header = <INPUTh>;
chomp $header;
my @header = split(/\t/,$header);
my %header=();
for(my $h=10; $h<=$#header; $h++){
my @header1 = split(/\=/,$header[$h]);
$header{$h} = $header1[0];
}
while(my $lineh = <INPUTh>){
chomp $lineh;

if(($lineh =~ /^#Potentially/)||($lineh !~ /\S+/)){
last;
}

my @infoh = split(/\t/,$lineh);
my $hg19_id = "$infoh[0]:$infoh[1]:$infoh[2]:$infoh[3]";
#print "hg19_id:$hg19_id\n";
$hg19_id =~ s/chr//g;
#print "line:$lineh\n";
for(my $n=10; $n <=$#infoh; $n++){
#print "header:$header{$n}\n";
$human_anno{$hg19_id}->{$header{$n}} = $infoh[$n];
}

}
}
######
#exit;
my $monkey_table = "/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_table_retcap_new2_rm8";
my $monkey_genotype_table = "/storage/chenlab/Users/junwang/monkey/data/retcap/monkey_variant_geno_table_retcap_new2_rm8";
#my $colony_table = "monkey/data/database/colony_table";
my $variant_table = "/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8";
my $var_AF = "/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8";
my %seq_method;
open(OUTmonkey,">$monkey_table");
open(OUTgeno,">$monkey_genotype_table");
#open(OUTcol,">$colony_table");
open(OUTanno,">$variant_table");
open(OUTAF, ">$var_AF");
###############3
my @col = ("Cayo","CNPRC","NEPRC","ONPRC","SNPRC","TNPRC","WNPRC","YNPRC");
print OUTAF "variant\t";
for(my $i=0; $i<=$#col; $i++){
print OUTAF $col[$i],"_het","\t";
print OUTAF $col[$i],"_hom","\t";
}

for(my $i=0; $i<=$#col; $i++){
print OUTAF $col[$i],"_AN","\t";
print OUTAF $col[$i],"_AC","\t";
print OUTAF $col[$i],"_het_GF","\t";
print OUTAF $col[$i],"_hom_GF","\t";
print OUTAF $col[$i],"_AF","\t";
}

print OUTAF "AN\tAC\thet\thom\thet_GF\thom_GF\tAF\n";

#############
print OUTgeno "ID\tmonkeyID\tgenotype\tsource_Capture\tlow_coverage_flag\n";
print OUTanno "ID\tmonkey_var_ID\trhemac10_chr\trhemac10_pos\trhemac10_ref\trhemac10_alt\tmonkey_genename\tmonkey_ensembl_gene\tmonkey_ensembl_trans\tmonkey_variant_type\tmonkey_var_eff\tmonkey_exon\tmonkey_cDNA_change\tmonkey_aa_change\thuman_ID\thg19_chr\thg19_pos\thg19_ref\thg19_alt\thuman_var_eff\thuman_refGene\thuman_refgene_detail\thuman_exon_func\thuman_refGene_aa\thuman_hgmd\thuman_ada_score\thuman_rf_score\thuman_rs_dbSNP150\thuman_Polyphen2\thuman_SIFT\thuman_REVEL\thuman_MutationAssessor\thuman_CADD\n";
$id=0;
for my $var_id (keys %monkey_genotype){
$id++;
####
#print "$var_id\n";
#if(!(defined $rhemac10_rhemac8{$var_id})){
#print "rhemac10_rhemac8:$var_id\n";
#}
################
print OUTAF "$var_id\t";
#my @var_coor_id = split(/\:/,$var_id);
my @coor=split(/\:/,$var_id);
my %col_AF=();
for(my $i=0; $i<=$#col; $i++){
if(!(defined $monkey_genotype_AC{$var_id}->{$col[$i]}->{het})){
#$monkey_genotype_AC{$var_id}->{$col[$i]}->{het}=0;

$col_AF{$var_id}->{$col[$i]}->{het}=0;
}else{
$col_AF{$var_id}->{$col[$i]}->{het} = keys %{$monkey_genotype_AC{$var_id}->{$col[$i]}->{het}};
}
print OUTAF "$col_AF{$var_id}->{$col[$i]}->{het}\t";

#print OUTAF "$monkey_genotype_AC{$var_id}->{$col[$i]}->{het}\t";

if(!(defined $monkey_genotype_AC{$var_id}->{$col[$i]}->{hom})){
#$monkey_genotype_AC{$var_id}->{$col[$i]}->{hom}=0;
$col_AF{$var_id}->{$col[$i]}->{hom}=0;
}else{
$col_AF{$var_id}->{$col[$i]}->{hom} = keys %{$monkey_genotype_AC{$var_id}->{$col[$i]}->{hom}};
}
#print OUTAF "$monkey_genotype_AC{$var_id}->{$col[$i]}->{hom}\t";
print OUTAF "$col_AF{$var_id}->{$col[$i]}->{hom}\t";
}

for(my $i=0; $i<=$#col; $i++){
my $indi_count=0;
if(defined $monkey_genotype_total{$var_id}->{$col[$i]}){
$indi_count= keys %{$monkey_genotype_total{$var_id}->{$col[$i]}};
}
my $AN=0;
if($coor[0] =~ /X/){
#$AN = $indi_count*0.5*2+$indi_count*0.5;
$AN = $indi_count*2;
}elsif($coor[0] =~ /Y/){
$AN= $indi_count;
}else{
$AN= $indi_count*2;
}
print OUTAF "$AN\t";

if(!(defined $monkey_genotype_AC{$var_id}->{$col[$i]}->{AC1})){
#$monkey_genotype_AC{$var_id}->{$col[$i]}->{AC}=0;
$col_AF{$var_id}->{$col[$i]}->{AC1}=0
}else{
$col_AF{$var_id}->{$col[$i]}->{AC1} = keys %{$monkey_genotype_AC{$var_id}->{$col[$i]}->{AC1}};
}

if(!(defined $monkey_genotype_AC{$var_id}->{$col[$i]}->{AC2})){
#$monkey_genotype_AC{$var_id}->{$col[$i]}->{AC}=0;
$col_AF{$var_id}->{$col[$i]}->{AC2}=0
}else{
$col_AF{$var_id}->{$col[$i]}->{AC2} = keys %{$monkey_genotype_AC{$var_id}->{$col[$i]}->{AC2}};
}

$col_AF{$var_id}->{$col[$i]}->{AC} = $col_AF{$var_id}->{$col[$i]}->{AC1} + 2* $col_AF{$var_id}->{$col[$i]}->{AC2};
#print OUTAF "$monkey_genotype_AC{$var_id}->{$col[$i]}->{AC}\t";
print OUTAF "$col_AF{$var_id}->{$col[$i]}->{AC}\t";
my ($het_GF,$hom_GF)=(0,0);
if($indi_count > 0){
#$het_GF = $monkey_genotype_AC{$var_id}->{$col[$i]}->{het}/$indi_count;
#$hom_GF = $monkey_genotype_AC{$var_id}->{$col[$i]}->{hom}/$indi_count;
$het_GF = $col_AF{$var_id}->{$col[$i]}->{het}/$indi_count;
$hom_GF = $col_AF{$var_id}->{$col[$i]}->{hom}/$indi_count;
}

print OUTAF "$het_GF\t$hom_GF\t";
my $AF = 0;
if($AN>0){
#$AF = $monkey_genotype_AC{$var_id}->{$col[$i]}->{AC}/$AN;
$AF = $col_AF{$var_id}->{$col[$i]}->{AC}/$AN;
}
print OUTAF "$AF\t";
}

######
my $indi_count=0;
if(defined $monkey_genotype_total{$var_id}->{total}){
$indi_count= keys %{$monkey_genotype_total{$var_id}->{total}};
}
my $AN=0;
if($coor[0] =~ /X/){
#$AN = $indi_count*0.5*2+$indi_count*0.5;
$AN = $indi_count*2;
}elsif($coor[0] =~ /Y/){
$AN= $indi_count;
}else{
$AN= $indi_count*2;
}
print OUTAF "$AN\t";

#if(!(defined $monkey_genotype_AC{$var_id}->{total}->{AC})){
#$monkey_genotype_AC{$var_id}->{total}->{AC}=0;
#}

#print OUTAF "$monkey_genotype_AC{$var_id}->{total}->{AC}\t";

if(!(defined $monkey_genotype_AC{$var_id}->{total}->{AC1})){
$col_AF{$var_id}->{total}->{AC1}=0
}else{
$col_AF{$var_id}->{total}->{AC1} = keys %{$monkey_genotype_AC{$var_id}->{total}->{AC1}};
}

if(!(defined $monkey_genotype_AC{$var_id}->{total}->{AC2})){
$col_AF{$var_id}->{total}->{AC2}=0
}else{
$col_AF{$var_id}->{total}->{AC2} = keys %{$monkey_genotype_AC{$var_id}->{total}->{AC2}};
}

$col_AF{$var_id}->{total}->{AC} = $col_AF{$var_id}->{total}->{AC1} + 2* $col_AF{$var_id}->{total}->{AC2};

print OUTAF "$col_AF{$var_id}->{total}->{AC}\t";



#if(!(defined $monkey_genotype_AC{$var_id}->{total}->{het})){
#$monkey_genotype_AC{$var_id}->{total}->{het}=0;
#}
#print OUTAF "$monkey_genotype_AC{$var_id}->{total}->{het}\t";

#if(!(defined $monkey_genotype_AC{$var_id}->{total}->{hom})){
#$monkey_genotype_AC{$var_id}->{total}->{hom}=0;
#}
#print OUTAF "$monkey_genotype_AC{$var_id}->{total}->{hom}\t";

if(!(defined $monkey_genotype_AC{$var_id}->{total}->{het})){
$col_AF{$var_id}->{total}->{het}=0;
}else{
$col_AF{$var_id}->{total}->{het} = keys %{$monkey_genotype_AC{$var_id}->{total}->{het}};
}
print OUTAF "$col_AF{$var_id}->{total}->{het}\t";

if(!(defined $monkey_genotype_AC{$var_id}->{total}->{hom})){
$col_AF{$var_id}->{total}->{hom}=0;
}else{
$col_AF{$var_id}->{total}->{hom} = keys %{$monkey_genotype_AC{$var_id}->{total}->{hom}};
}

print OUTAF "$col_AF{$var_id}->{total}->{hom}\t";



my ($het_GF, $hom_GF) = (0,0);
if($indi_count > 0){
#$het_GF = $monkey_genotype_AC{$var_id}->{total}->{het}/$indi_count;
#$hom_GF = $monkey_genotype_AC{$var_id}->{total}->{hom}/$indi_count;
$het_GF = $col_AF{$var_id}->{total}->{het}/$indi_count;
$hom_GF = $col_AF{$var_id}->{total}->{hom}/$indi_count;

}
print OUTAF "$het_GF\t$hom_GF\t";
my $AF=0;
if($AN >0){
#$AF = $monkey_genotype_AC{$var_id}->{total}->{AC}/$AN;
$AF = $col_AF{$var_id}->{total}->{AC}/$AN;
}
print OUTAF "$AF\n";

################

#print OUTanno 
my @tmp_arr = ("genename","ensembl_gene","ensembl_trans","variant_type","variant_eff","exon","cDNA_change","aa_change");
for my $tmp_arr ( @tmp_arr){
if(!(defined $var_hash{$var_id}->{monkey}->{$tmp_arr})){
$var_hash{$var_id}->{monkey}->{$tmp_arr}=".";
}
}
print OUTanno "$id\t$var_id\t$coor[0]\t$coor[1]\t$coor[2]\t$coor[3]\t$var_hash{$var_id}->{monkey}->{genename}\t$var_hash{$var_id}->{monkey}->{ensembl_gene}\t$var_hash{$var_id}->{monkey}->{ensembl_trans}\t$var_hash{$var_id}->{monkey}->{variant_type}\t$var_hash{$var_id}->{monkey}->{variant_eff}\t$var_hash{$var_id}->{monkey}->{exon}\t$var_hash{$var_id}->{monkey}->{cDNA_change}\t$var_hash{$var_id}->{monkey}->{aa_change}\t";
if(defined $rhemac10_hg19{$var_id}){
my $hg19_id =$rhemac10_hg19{$var_id};
my @coor_hg=split(/\:/,$hg19_id);
my @tmp_arr = ("Func.refGene","Gene.refGene","GeneDetail.refGene","ExonicFunc.refGene","AAChange.refGene","HGMD_mutations_nearby","ada_score","rf_score","rs_dbSNP150","Polyphen2_HVAR_pred","SIFT_pred","REVEL_score","MutationAssessor_pred","CADD_raw_rankscore");
for my $tmp_arr ( @tmp_arr){
if(!(defined $human_anno{$hg19_id}->{$tmp_arr})){
$human_anno{$hg19_id}->{$tmp_arr}=".";
}
}
print OUTanno "$hg19_id\t$coor_hg[0]\t$coor_hg[1]\t$coor_hg[2]\t$coor_hg[3]\t",$human_anno{$hg19_id}->{"Func.refGene"},"\t",$human_anno{$hg19_id}->{"Gene.refGene"},"\t",$human_anno{$hg19_id}->{"GeneDetail.refGene"},"\t",$human_anno{$hg19_id}->{"ExonicFunc.refGene"},"\t",$human_anno{$hg19_id}->{"AAChange.refGene"},"\t$human_anno{$hg19_id}->{HGMD_mutations_nearby}\t$human_anno{$hg19_id}->{ada_score}\t$human_anno{$hg19_id}->{rf_score}\t$human_anno{$hg19_id}->{rs_dbSNP150}\t$human_anno{$hg19_id}->{Polyphen2_HVAR_pred}\t$human_anno{$hg19_id}->{SIFT_pred}\t$human_anno{$hg19_id}->{REVEL_score}\t$human_anno{$hg19_id}->{MutationAssessor_pred}\t$human_anno{$hg19_id}->{CADD_raw_rankscore}\n";
#}#elsif(!(defined $rhemac10_rhemac8{$var_id})){
#print "rhemac10_rhemac8:$var_id\n";
}elsif(defined $rhemac10_rhemac8{$var_id}){
if(defined $rhemac8_hg19{$rhemac10_rhemac8{$var_id}}){


my $hg19_id =$rhemac8_hg19{$rhemac10_rhemac8{$var_id}};
my @coor_hg=split(/\:/,$hg19_id);

print OUTanno  "$hg19_id\t$coor_hg[0]\t$coor_hg[1]\t$coor_hg[2]\t$coor_hg[3]\t",$human_anno{$hg19_id}->{"Func.refGene"},"\t",$human_anno{$hg19_id}->{"Gene.refGene"},"\t",$human_anno{$hg19_id}->{"GeneDetail.refGene"},"\t",$human_anno{$hg19_id}->{"ExonicFunc.refGene"},"\t",$human_anno{$hg19_id}->{"AAChange.refGene"},"\t$human_anno{$hg19_id}->{HGMD_mutations_nearby}\t$human_anno{$hg19_id}->{ada_score}\t$human_anno{$hg19_id}->{rf_score}\t$human_anno{$hg19_id}->{rs_dbSNP150}\t$human_anno{$hg19_id}->{Polyphen2_HVAR_pred}\t$human_anno{$hg19_id}->{SIFT_pred}\t$human_anno{$hg19_id}->{REVEL_score}\t$human_anno{$hg19_id}->{MutationAssessor_pred}\t$human_anno{$hg19_id}->{CADD_raw_rankscore}\n";
}else{
print OUTanno ".\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\n";

}

}else{


print OUTanno ".\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\t.\n";
}
#####
for my $monkey (keys %{$monkey_genotype{$var_id}}){
if(defined $monkey_genotype{$var_id}->{$monkey}->{gt_detail}){
print OUTgeno "$id\t$var_id\t$monkey\t$monkey_genotype{$var_id}->{$monkey}->{gt_detail}\t$monkey_genotype{$var_id}->{$monkey}->{seq}\tPASS\n";
$seq_method{$monkey}->{$monkey_genotype{$var_id}->{$monkey}->{seq}}=1;
}
}
}

print OUTmonkey "monkeyID\tcolonyID\tmonkey_internal_ID\n";
for my $monkey (keys %monkey_ID){
for my $col (keys %{$monkey_ID{$monkey}->{col}}){
 print OUTmonkey "$monkey\t$col\t$internal_ID{$monkey}\n";
my @seq_method = keys %{$seq_method{$monkey}};
my $seq_method = join("\;",@seq_method);
}
}



