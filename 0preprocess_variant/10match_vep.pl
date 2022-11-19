#!/usr/bin/perl -w
use strict;
my $target ="/storage/chenlab/Users/junwang/monkey/data/retcap/panel.100416.liftover.design.txt_gene_final";
my %target;
open(INPUT,$target);
while(my $line = <INPUT>){
chomp $line;
$target{$line}=1;
}
my $file = "/storage/chenlab/Users/junwang/monkey/data/database/variant_table_GVCFs.10_retcap2_updated_AF_var.vep.101";

open(INPUT,$file);
my %var_hash;
while(my $line = <INPUT>){
if($line =~ /^#/){
next;
}
chomp $line;
my @info = split(/\t/,$line);
#if($info[4] =~ /\*/){
if($info[4] eq '*'){
next;
}
my $tmp_id = "$info[0]:$info[1]:$info[3]:$info[4]";
my $var_id = $tmp_id;
my @var1 = split(/\=/,$info[7]);
my @var2 = split(/\,/,$var1[1]);
for(my $v=0; $v<=$#var2; $v++){
my @var3 = split(/\|/,$var2[$v]);

####deal with indel###########
my $tmp_var = "$info[3]"."$var3[0]";
if($var3[0] eq "-"){
$tmp_var = $info[4];
}
##################

if((($info[4] eq $var3[0])&&(length($info[3])==1)&&(length($info[4])==1))||(($info[4] eq $tmp_var)&&(( length($info[3])>1 )||( length($info[4])>1 )))){
#######if($info[4] eq $var3[0]){####read the first annotation of monkey
if(defined $target{$var3[3]}){
if(($var3[3] eq "C1QTNF5")||( $var3[3] eq "RP9"  )||( $var3[3] eq "SLCO1B1"  )){
 print "$line\n";
}
if($var3[1] =~ /\S+/){
$var_hash{$var_id}->{monkey}->{variaint_type} = "$var3[1]";
}else{
$var_hash{$var_id}->{monkey}->{variaint_type} = ".";
}
if($var3[2] =~ /\S+/){
$var_hash{$var_id}->{monkey}->{variaint_eff} = "$var3[2]";
}else{
$var_hash{$var_id}->{monkey}->{variaint_eff} = ".";
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
}
}
my $var_table="monkey/data/retcap/variant_table_retcap_new2_rm8";


my $output = $var_table."_corrected_vep101_target";
my $output1 = $var_table."_corrected_vep101_target_missing";
open(OUTPUT,">$output");
open(OUTPUT1,">$output1");
open(INPUT1,$var_table);
my $header = <INPUT1>;
print OUTPUT "$header";
my $id=0;
my %id_var;
while(my $line1 = <INPUT1>){
chomp $line1;
$id++;
my @info1 = split(/\t/,$line1);
my @coor=split(/\:/,$info1[1]);
my $var_id = $info1[1];
$id_var{$var_id}->{id}=$id;
if($info1[14] =~ /\:/){
$id_var{$var_id}->{hg}=$info1[14];
}
if(defined $var_hash{$var_id}){
print OUTPUT "$id\t$info1[1]\t$coor[0]\t$coor[1]\t$coor[2]\t$coor[3]\t$var_hash{$var_id}->{monkey}->{genename}\t$var_hash{$var_id}->{monkey}->{ensembl_gene}\t$var_hash{$var_id}->{monkey}->{ensembl_trans}\t$var_hash{$var_id}->{monkey}->{variaint_type}\t$var_hash{$var_id}->{monkey}->{variaint_eff}\t$var_hash{$var_id}->{monkey}->{exon}\t$var_hash{$var_id}->{monkey}->{cDNA_change}\t$var_hash{$var_id}->{monkey}->{aa_change}\t";

for(my $i=14;$i<=$#info1-1; $i++){
print OUTPUT "$info1[$i]\t";
}

print OUTPUT "$info1[$#info1]\n";
}else{
print OUTPUT1 "$var_id\n";

}
}
my %ref_issue_rhemac10;
my @rhemac10_file=("forDistribution_1-2UC_ucdavis.1-2.retinal.snps_gatkfiltered.vcf.gz.splitMuliallele",  "retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget1_gatkfiltered.vcf.gz.splitMuliallele");

for my $rhemac10_file (@rhemac10_file){
my $new_rhemac10_file = "monkey/data/database/$rhemac10_file"."_rheMac10_w_header_norm_ref_log";
open(INPUTnew,$new_rhemac10_file);
while(my $line2 = <INPUTnew>){
chomp $line2;
if($line2 =~ /^REF_MISMATCH/){
my @info2 = split(/\s+/,$line2);
my $id = "$info2[1]:$info2[2]:$info2[3]";
$id =~ s/chr//g;
$ref_issue_rhemac10{$id}=1;
}
}
}

my %ref_issue_hg19;

for my $hg19_file (@rhemac10_file){
my $new_hg19_file = "monkey/data/database/$hg19_file"."_rheMac10_hg19AF_w_header_norm_ref_log";
open(INPUTnew,$new_hg19_file);
while(my $line2 = <INPUTnew>){
chomp $line2;
if($line2 =~ /^REF_MISMATCH/){
my @info2 = split(/\s+/,$line2);
my $id = "$info2[1]:$info2[2]:$info2[3]";
$id =~ s/chr//g;
$ref_issue_hg19{$id}=1;
}
}
}


my @hg19_file=("retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep_gatkfiltered.vcf.gz.splitMuliallele");


for my $hg19_file (@hg19_file){
my $new_hg19_file = "monkey/data/database/$hg19_file"."_hg19AF_w_header_norm_ref_log";
open(INPUTnew1,$new_hg19_file);
while(my $line2 = <INPUTnew1>){
chomp $line2;
if($line2 =~ /^REF_MISMATCH/){
my @info2 = split(/\s+/,$line2);
my $id = "$info2[1]:$info2[2]:$info2[3]";
$id =~ s/chr//g;
$ref_issue_hg19{$id}=1;
}
}
}


my $input = "monkey/data/retcap/monkey_variant_geno_table_retcap_new2_rm8"; 

my $output1=$input."_corrected_target";

open(OUTPUT1,">$output1");

my $output2 = $input."_seq_WES_target";
open(OUTPUT2,">$output2");

my $output3 = $input."_seq_capture_target";
open(OUTPUT3,">$output3");

#ID      monkeyID        genotype        source_WES_or_Capture   low_coverage_flag
#1       5:48856289:G:A  CNPRC_37543     0/1:18,30:48:99:0|1:49479581_G_A:931,0,202      UC_Capture      PASS
my %var_seq;
open(INPUT,$input);
my %monkey;
my $header = <INPUT>;
print OUTPUT1 "$header";
while(my $line = <INPUT>){
chomp $line;
my @info = split(/\t/,$line);
$monkey{$info[2]}=1;
$var_seq{$info[1]}->{$info[-2]}=1;

if(defined $id_var{$info[1]}){
my $note = $info[5];

my @coor = split(/\:/,$info[1]);
my $rhemac_id = "$coor[0]:$coor[1]:$coor[2]";
if(defined $ref_issue_rhemac10{$rhemac_id}){
$note .= ",rhemac10_reference_mismatch";
}
my $hg_id;
if((defined $id_var{$info[1]}->{hg})&& ($id_var{$info[1]}->{hg} ne ".")){
my @coor1 = split(/\:/,$id_var{$info[1]}->{hg});
$hg_id = "$coor1[0]:$coor1[1]:$coor1[2]";
if(($hg_id =~ /\:/)&&(defined $ref_issue_hg19{$hg_id})){
$note .= ",hg19_reference_mismatch";
}

}

 
print OUTPUT1 "$id_var{$info[1]}->{id}\t$info[1]\t$info[2]\t$info[3]\t$info[4]\t$note\n";
}
}


for my $var (keys %var_seq){
my @seq = keys %{$var_seq{$var}};
my $key_line = join("|",@seq);

if(defined $var_seq{$var}->{WES}){
print OUTPUT2 "$var\t$key_line\n";
}else{
print OUTPUT3 "$var\t$key_line\n";
}
}
my $monkey_table = "monkey/data/retcap/monkey_table_retcap_new2_rm8";

#my %monkey;
#monkeyID        colonyID        monkey_internal_ID
#YNPRC_REf11     YNPRC   35626
my $output2 = $monkey_table."_corrected_target";
open(OUTPUT2,">$output2");
open(INPUT,$monkey_table);
my $header = <INPUT>;
print OUTPUT2 "$header";
while(my $line = <INPUT>){
chomp $line;
my @info = split(/\t/,$line);
if(defined $monkey{$info[0]}){
print OUTPUT2 "$line\n";
}
}
