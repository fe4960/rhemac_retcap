#!/usr/bin/perl -w
use strict;
my @file = ("forDistribution_1-2UC_ucdavis.1-2.retinal.snps", "forDistribution_1-2UC_ucdavis.1-2.retinal.indels","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.snps.filtered.vep.removed.onTarget","retinal_raw_GATK.GenotypeGVCFs.plates1_6_Cayo1_2.455.indels.filtered.vep.removed.onTarget","genotypeGVCFs.10_output.filtered.snps.removed.vep.no.isoseq", "genotypeGVCFs.10_output.filtered.indels.removed.vep.no.isoseq.sorted.fix", "retcap_genotypeGVCFs.2_output.filtered.snps.removed.vep", "retcap_genotypeGVCFs.2_output.filtered.indels.removed.vep" ); 
for my $file (@file){
my $newfile = "/storage/chenlab/Users/junwang/monkey/data/database/$file"."_gatkfiltered.vcf.gz.splitMuliallele";
open(INPUT,$newfile);
my $output = "$newfile".".flt.GQ_DP_AB_new";

open(OUTPUT,">$output");
line1: while(my $line = <INPUT>){
chomp $line;

if($line =~ /^#/){
print OUTPUT "$line\n";
}else{
my @info = split(/\s+/,$line);
my $AC=0;
my @fmt = split(/\:/,$info[8]);
my %fmt;
for(my $j=0; $j<=$#fmt; $j++){
$fmt{$fmt[$j]} = $j;
}
my $new_line;
for(my $i=0; $i<=8; $i++){
$new_line .= "$info[$i]\t";
}
for(my $i=9; $i<=$#info; $i++){
my @info1 = split(/\:/,$info[$i]);
#GT:AD:DP:GQ:PL\t0/1:13,11:24:99:325,0,405
my @AB = split(/\,/,$info1[1]);
my $nonzero_gt=0;
for(my $k=0; $k<=$#AB; $k++){
if($AB[$k] >0){
$nonzero_gt++;
}
}
if($nonzero_gt >2){
goto line1;
}
if($info1[$fmt{"GQ"}] eq "."){
$info1[$fmt{"GQ"}]=0;
}

if($info1[$fmt{"DP"}] eq "."){
$info1[$fmt{"DP"}]=0;
}
if(($info1[$fmt{"GQ"}]>=20)&&($info1[$fmt{"DP"}]>=10)){

#if(($info1[$fmt{"GQ"}]>=20)&&($info1[$fmt{"DP"}]>=10)&&($info1[$fmt{"DP"}]<=400)){

#if(($info1[$fmt{"GQ"}]>=20)&&($info1[$fmt{"DP"}]>=10)&&($info1[$fmt{"DP"}]<=200)){
$new_line .= "$info[$i]\t";
my @gt_id;
if($info1[0] =~ /\//){
@gt_id = split(/\//,$info1[0]);
}elsif($info1[0] =~ /\|/){
@gt_id = split(/\|/,$info1[0]);
}
#if(!(defined $gt_id[1])){
#print "$info[$i]\n";
#print "$info1[0]\n";
#}
if(($gt_id[0] eq $gt_id[1])&&($gt_id[0]!=0)){
$AC++;
#}elsif(($gt_id[0]!=$gt_id[1])&&($gt_id[0]!=0)&&($gt_id[1]!=0)){
#$AC++;
}elsif($gt_id[0]!=$gt_id[1]){
my $AB=0;
my $nc=0;
my $nc1=0;
if($gt_id[0]!=0){
$nc=$gt_id[0];
}
if($gt_id[1] !=0){
$nc1 = $gt_id[1];
}
if($AB[$nc1] > $AB[$nc]){
$AB=$AB[$nc]/($AB[$nc1]+$AB[$nc]);
}elsif($AB[$nc] > $AB[$nc1]){
$AB = $AB[$nc1]/($AB[$nc1] + $AB[$nc]);
}
if($AB > 0.2){
$AC++;
}
}
}else{
$new_line .= "./.:".join(":",@info1[1..$#info1])."\t";
}
}
if($AC>0){
print OUTPUT "$new_line\n";
}
}
}
}
