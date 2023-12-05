#!/usr/bin/perl -w
use strict;
my $main = "/storage/chen/home/jw29";
my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_clean_hg19_nt.fa";
my %hg19_nt;
open(INPUT,$file);
while(my $line = <INPUT>){
chomp $line;
#>1:216040358:C:A::chr1:216040357-216040358
#C
if($line =~ /^>(\S+)/){
my @id = split(/\:/,$1);
my $id = "$id[0]:$id[1]:$id[2]:$id[3]";
my $nt = <INPUT>;
chomp $nt;
$hg19_nt{$id}=uc($nt);
}
}
#my $var_file = "/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_clean"; 
my $var_file = "/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated";
#my $temp = "ABCA4";
#my $temp = "PDE6B";
#my $temp = "$ARGV[0]";
my $temp = "tmp"; #$ARGV[1];
my $freq_cut = 1; #0;
my $output = $var_file."_gnomad";

open(OUTPUT,">$output") || die ("$output");

my $tabix  ="$main/software/htslib-1.6/tabix";
my $gnomad = "/storage/chenlab/Users/junwang/gnomAD/gnomad.exomes.r2.1.1.sites.vcf.bgz";
#NO      1       13445   C       A       1       0.000315258511979823    DDX11L1|DDX11L1 nonsynonymous_SNV       RP:solved_RP:SRF_980
#YES     1       1993722 C       T       2.0     0.00537634408602150538  PRKCZ   intron_variant  unsolved_LCA:1275:1/1:6:0:6:.
open(INPUT,$var_file) || die ("$var_file");
my %hash;
my $header = <INPUT>;
chomp $header;
print OUTPUT "$header\tgnomad_AF\tgnomad_AC\tgnomad_AN\n"; #\tgnomad_AF_max\tgnomad_AC_max\tgnomad_AN_max\n";
while(my $line = <INPUT>){
if($line =~ /^#/){
next;
}
chomp $line;
my $AF_max = 0;
my $AC_max=0;
my $AN_max=0;
my $AF = 0;
my $AC=0;
my $AN=0;
my @info = split(/\t/,$line);

if($info[14] ne "\."){
my @info2 = split(/\:/,$info[14]);
my $region = "$info2[0]:$info2[1]-$info2[1]";
my $ref = uc($info2[2]);
my $alt = uc($info2[3]);
my $temp_line = "$main/HGMD/data/tabix_$temp"."_retcap";
` $tabix $gnomad $region > $temp_line`;
open(INPUT1,$temp_line) || die ("$temp_line");
my $flag_wes=0;
my $flag_wes_concern=0;
my %hash_other=();
my $AN_concern=0;
while(my $line1 = <INPUT1>){

my @info1 = split(/\s+/,$line1);
if((length($info1[3]) > 1) || (length($info1[4]) > 1)){
next;
}
if(($info2[0] eq "$info1[0]") && ($info2[1] == $info1[1])&&(uc($info1[4])eq $alt)){

#if(($info2[0] eq "$info1[0]") && ($info2[1] == $info1[1])&&(uc($info1[3]) eq $ref)&&(uc($info1[4])eq $alt)){
if($line1 =~ /\;AF_popmax\=(\S+)\;/){
my @AF_max = split(/\;/,$1);
$AF_max = $AF_max[0];
if($line1=~/\;AC_popmax\=(\S+)\;/){
my @AC_max = split(/\;/,$1);
$AC_max = $AC_max[0];
}
if($line1=~/\;AN_popmax\=(\S+)\;/){
my @AN_max = split(/\;/,$1);
$AN_max = $AN_max[0];
}
if($line1=~/\s+AC\=(\S+)\;/){
my @AC = split(/\;/,$1);
$AC = $AC[0];
}
if($line1=~/\;AN\=(\S+)\;/){
my @AN = split(/\;/,$1);
$AN = $AN[0];
}
if($line1=~/\;AF\=(\S+)\;/){
my @AF = split(/\;/,$1);
$AF = $AF[0];
}
$flag_wes=1;

last;
}
}
#############
if($flag_wes==0){
($AF_max,$AC_max,$AN_max,$AF,$AC,$AN)=(0,0,0,0,0,0);
my $coor="$info1[0]:$info1[1]:$info1[3]:$info1[4]";
if(($info2[0] eq "$info1[0]") && ($info2[1] == $info1[1])&&(uc($info1[3]) eq $alt)){

#if(($info2[0] eq "$info1[0]") && ($info2[1] == $info1[1])&&(uc($info1[3]) eq $alt)&&(uc($info1[4])eq $ref)){
if($line1 =~ /\;AF_popmax\=(\S+)\;/){
my @AF_max = split(/\;/,$1);
$AF_max = $AF_max[0];
if($line1=~/\;AC_popmax\=(\S+)\;/){
my @AC_max = split(/\;/,$1);
$AC_max = $AC_max[0];
}
if($line1=~/\;AN_popmax\=(\S+)\;/){
my @AN_max = split(/\;/,$1);
$AN_max = $AN_max[0];
}
if($line1=~/\s+AC\=(\S+)\;/){
my @AC = split(/\;/,$1);
$AC = $AC[0];
#$flag_wes=1;
}
if($line1=~/\;AN\=(\S+)\;/){
my @AN = split(/\;/,$1);
$AN = $AN[0];
}
if($line1=~/\;AF\=(\S+)\;/){
my @AF = split(/\;/,$1);
$AF = $AF[0];
}
my $tmp_AC_max= $AC_max;
 $AC_max = $AN_max - $tmp_AC_max;
 $AF_max = $AC_max/$AN_max;
 $flag_wes_concern=1;
 $hash_other{$coor}->{AC}=$AC;
 $hash_other{$coor}->{AN} = $AN;
 $hash_other{$coor}->{AF} = $AC/$AN;
 $AN_concern = $AN;
}
}

#######elsif(($info2[0] eq "$info1[0]") && ($info2[1] == $info1[1])&&(uc($info1[3]) eq $alt)&&(uc($info1[4]) ne $ref)){
#my $coor="$info1[0]:$info1[1]:$info1[3]:$info1[4]";
#if($line1 =~ /\;AF_popmax\=(\S+)\;/){
#my @AF_max = split(/\;/,$1);
#$AF_max = $AF_max[0];
#if($line1=~/\;AC_popmax\=(\S+)\;/){
#my @AC_max = split(/\;/,$1);
#$AC_max = $AC_max[0];
#}
#if($line1=~/\;AN_popmax\=(\S+)\;/){
#my @AN_max = split(/\;/,$1);
#$AN_max = $AN_max[0];
#}
#if($line1=~/\s+AC\=(\S+)\;/){
#my @AC = split(/\;/,$1);
#$AC = $AC[0];
#}
#if($line1=~/\;AN\=(\S+)\;/){
#my @AN = split(/\;/,$1);
#$AN = $AN[0];
#}
#if($line1=~/\;AF\=(\S+)\;/){
#my @AF = split(/\;/,$1);
#$AF = $AF[0];
#}
#my $tmp_AC_max= $AC_max;
# $AC_max = $AN_max - $tmp_AC_max;
# $AF_max = $AC_max/$AN_max;
#$hash_other{$coor}->{AC} = $AC;
#$hash_other{$coor}->{AN} = $AN;
#$hash_other{$coor}->{AF} = $AC/$AN;
#}
#}
##########
}
}
if($flag_wes_concern ==1){
$AN=$AN_concern;
my $AC_total=0;
for my $coor_key ( keys %hash_other){
if($hash_other{$coor_key}->{AN}!=$AN_concern){
print "$coor_key\t$info2[0]:$info2[1]:$alt:$ref\n";
exit;
}
$AC_total+=$hash_other{$coor_key}->{AC};
}
$AC= $AN - $AC_total;
$AF = $AC/$AN;
$flag_wes=1;
}elsif($flag_wes==0){
($AF_max,$AC_max,$AN_max,$AF,$AC,$AN)=(0,0,0,0,0,0);
} 
my $flag_wgs=0;
my $flag_wgs_concern=0;
my %hash_other_wgs=();
my $AN_concern_wgs=0;
if($flag_wes == 0){
($AF_max,$AC_max,$AN_max,$AF,$AC,$AN)=(0,0,0,0,0,0);
#my $gnomad_wgs = "/storage/novaseq/backup_jw/gnomad/gnomad.genomes.r2.1.1.sites.vcf.bgz";
my $gnomad_wgs = "/storage/chenlab/Users/junwang/gnomAD/gnomad.genomes.r2.1.1.sites.vcf.bgz";
` $tabix $gnomad_wgs $region > $temp_line`;
open(INPUT1,$temp_line) || die ("$temp_line") ;
while(my $line1 = <INPUT1>){
my @info1 = split(/\s+/,$line1);
if((length($info1[3]) > 1) || (length($info1[4]) > 1)){
next;
}

if(($info[0] eq "$info1[0]") && ($info[1] == $info1[1])&&(uc($info1[4])eq $alt)){

#if(($info[0] eq "$info1[0]") && ($info[1] == $info1[1])&&(uc($info1[3]) eq $ref)&&(uc($info1[4])eq $alt)){
if($line1 =~ /\;AF_popmax\=(\S+)\;/){
my @AF_max = split(/\;/,$1);
$AF_max = $AF_max[0];
if($line1=~/\;AC_popmax\=(\S+)\;/){
my @AC_max = split(/\;/,$1);
$AC_max = $AC_max[0];
}
if($line1=~/\;AN_popmax\=(\S+)\;/){
my @AN_max = split(/\;/,$1);
$AN_max = $AN_max[0];
}
if($line1=~/\s+AC\=(\S+)\;/){
my @AC = split(/\;/,$1);
$AC = $AC[0];
}
if($line1=~/\;AN\=(\S+)\;/){
my @AN = split(/\;/,$1);
$AN = $AN[0];
}
if($line1=~/\;AF\=(\S+)\;/){
my @AF = split(/\;/,$1);
$AF = $AF[0];
}
$flag_wgs=1;

last;
}
}
##########
if(($flag_wes ==0) &&($flag_wgs==0)){
($AF_max,$AC_max,$AN_max,$AF,$AC,$AN)=(0,0,0,0,0,0);
my $coor="$info1[0]:$info1[1]:$info1[3]:$info1[4]";
if(($info[0] eq "$info1[0]") && ($info[1] == $info1[1])&&(uc($info1[3]) eq $alt)){

#if(($info[0] eq "$info1[0]") && ($info[1] == $info1[1])&&(uc($info1[3]) eq $alt)&&(uc($info1[4])eq $ref)){
if($line1 =~ /\;AF_popmax\=(\S+)\;/){
my @AF_max = split(/\;/,$1);
$AF_max = $AF_max[0];
if($line1=~/\;AC_popmax\=(\S+)\;/){
my @AC_max = split(/\;/,$1);
$AC_max = $AC_max[0];
}
if($line1=~/\;AN_popmax\=(\S+)\;/){
my @AN_max = split(/\;/,$1);
$AN_max = $AN_max[0];
}
if($line1=~/\s+AC\=(\S+)\;/){
my @AC = split(/\;/,$1);
$AC = $AC[0];
#$flag_wgs=1;
}
if($line1=~/\;AN\=(\S+)\;/){
my @AN = split(/\;/,$1);
$AN = $AN[0];
}
if($line1=~/\;AF\=(\S+)\;/){
my @AF = split(/\;/,$1);
$AF = $AF[0];
}
my $tmp_AC_max= $AC_max;
 $AC_max = $AN_max - $tmp_AC_max;
 $AF_max = $AC_max/$AN_max;
my $tmp_AC = $AC;
$flag_wgs_concern=1;
 $hash_other_wgs{$coor}->{AC}=$AC;
 $hash_other_wgs{$coor}->{AN} = $AN;
 $hash_other_wgs{$coor}->{AF} = $AC/$AN;
 $AN_concern_wgs = $AN;
}
}

#elsif( ($info[0] eq "$info1[0]") && ($info[1] == $info1[1])&&(uc($info1[3]) eq $alt)&&(uc($info1[4]) ne $ref)   ){
#if($line1 =~ /\;AF_popmax\=(\S+)\;/){
#my @AF_max = split(/\;/,$1);
#$AF_max = $AF_max[0];
#if($line1=~/\;AC_popmax\=(\S+)\;/){
#my @AC_max = split(/\;/,$1);
#$AC_max = $AC_max[0];
#}
#if($line1=~/\;AN_popmax\=(\S+)\;/){
#my @AN_max = split(/\;/,$1);
#$AN_max = $AN_max[0];
#}
#if($line1=~/\s+AC\=(\S+)\;/){
#my @AC = split(/\;/,$1);
#$AC = $AC[0];
#$flag_wgs=1;
#}
#if($line1=~/\;AN\=(\S+)\;/){
#my @AN = split(/\;/,$1);
#$AN = $AN[0];
#}
#if($line1=~/\;AF\=(\S+)\;/){
#my @AF = split(/\;/,$1);
#$AF = $AF[0];
#}
#my $tmp_AC_max= $AC_max;
# $AC_max = $AN_max - $tmp_AC_max;
# $AF_max = $AC_max/$AN_max;
#my $tmp_AC = $AC;
#$hash_other_wgs{$coor}->{AC}=$AC;
# $hash_other_wgs{$coor}->{AN} = $AN;
# $hash_other_wgs{$coor}->{AF} = $AC/$AN;
#}
#}
###########
}
}
if($flag_wgs_concern ==1){
$AN=$AN_concern_wgs;
my $AC_total_wgs=0;
for my $coor_key ( keys %hash_other_wgs){
if($hash_other_wgs{$coor_key}->{AN}!=$AN_concern_wgs){
print "$coor_key\t$info2[0]:$info2[1]:$alt:$ref\n";
exit;
}
$AC_total_wgs+=$hash_other{$coor_key}->{AC};
}
$AC= $AN - $AC_total_wgs;
$AF = $AC/$AN;
$flag_wgs=1;
}elsif(($flag_wgs==0)&&($flag_wes==0)){
$AC=0;
$AN=0;
$AF=0;
}
}
#}
if(($flag_wgs==0)&&($flag_wes==0)){
if($hg19_nt{$info[14]} eq $alt){
$AF=1;
$AC="NA";
$AN="NA";
}
}
}
#print OUTPUT "$line\t$max_ac\t$max_freq\t$max_an\t$ac\t$freq\t$an\t$hom\n";
 print OUTPUT "$line\t$AF\t$AC\t$AN\n"; #\t$AF_max\t$AC_max\t$AN_max\n"; #AF:$AF;AC:$AC;AN:$AN;AF_max:$AF_max;AC_max:$AC_max;AN_max:$AN_max\n";
#}
}


sub chi2_p {
my $R_script = "STGD/scripts/R_tmp1001.R";
my $R_out = "STGD/scripts/R_tmp1001.out";

open (OUTFILE, ">$R_script");
print OUTFILE "pvalues<-pchisq(", "$_[0]",", df=", "$_[1]",", lower.tail = FALSE)\n";
print OUTFILE "write(pvalues\,\"$R_out\")";
close OUTFILE;
`R < $R_script --no-save --slave`;
open INFILE, "<$R_out";
my $file = <INFILE>;
my @results = split(/\s+/,$file);
`rm $R_script $R_out`;
close INFILE;
return($results[0]);
}


sub fisher_test {
my $R_script = "STGD/scripts/R_tmp1001.R";
my $R_out = "STGD/scripts/R_tmp1001.out";
print "enter\n";
open (OUTFILE, ">$R_script");
print OUTFILE	"Tea = matrix(c($_[0]\,$_[1]\,$_[2]\,$_[3])\,nrow=2\,dimnames =list(Guess = c(\"Milk\"\,\"Tea\")\,Truth = c(\"Milk\"\,\"Tea\")))\n";
print OUTFILE	"pvalues<-fisher.test(Tea\, alternative=\"$_[4]\")\n";
print OUTFILE "write(pvalues\$p\.value,(\"$R_out\"))\n";
close OUTFILE;
`R < $R_script --no-save --slave`;
open INFILE, "<$R_out";
my $file = <INFILE>;
my @results = split(/\s+/,$file);
`rm $R_script $R_out`;
close INFILE;
return($results[0]);
}
