#!/usr/bin/perl -w
use strict;
my $main = "/storage/chen/home/jw29";
#my $var_file = "HGMD/data/HGMD_2014_2016_all_gene_7000_$ARGV[0]";
#my $var_file = "/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF_50000_".$ARGV[0];
my $var_file = "monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_patho_extend_all_patho_flt";
#my $temp = "ABCA4";
#my $temp = "PDE6B";
#my $temp = "$ARGV[0]";
my $temp = "patho"; #$ARGV[0];
my $freq_cut = 10;
my $output = $var_file."_new_maxAF$freq_cut";

open(OUTPUT,">$output") || die ("$output");

my $tabix  ="$main/software/htslib-1.6/tabix";
#my $gnomad = "/storage/chen/tmp/disease_gene/gnomad/gnomad_pop_freq_new_sort.gz";
#my $gnomad = "/storage/novaseq/backup_jw/gnomad/gnomad.exomes.r2.1.1.sites.vcf.gz";
my $gnomad = "/storage/chenlab/Users/junwang/gnomAD/gnomad.exomes.r2.1.1.sites.vcf.bgz";
#my $gnomad = "$main/gnomad/data/gnomad_exomes_r2.0.1.sites_sort_5-26-2017.gz";
#NO      1       13445   C       A       1       0.000315258511979823    DDX11L1|DDX11L1 nonsynonymous_SNV       RP:solved_RP:SRF_980
#YES     1       1993722 C       T       2.0     0.00537634408602150538  PRKCZ   intron_variant  unsolved_LCA:1275:1/1:6:0:6:.
open(INPUT,$var_file) || die ("$var_file");
my %hash;
my $line = <INPUT>;
chomp $line;
print OUTPUT "$line\tAF\tAC\tAN\tAF_max\tAC_max\tAN_max\thom\n";
while(my $line = <INPUT>){
if($line =~ /^#/){
next;
}
chomp $line;
my @info = split(/\s+/,$line);
#$info[0] =~ s/chr//g;

my @info2 = split(/\:/,$info[1]);
$info2[0] =~ s/chr//g;
#1/1:7:0:7:. 
#my @gt = split(/\:/,$info[9]);
#my $total = $gt[1]+$gt[2];
#if(($total >=10) && (( $gt[1]/$total) >= 0.15)){

#my @info2 = split(/:/,$info[0]);
#my @info2 = @info;
my $region = "$info2[0]:$info2[1]-$info2[1]";
#my $ref = uc($info2[4]);
#my $alt = uc($info2[5]);
my $ref = uc($info2[2]);
my $alt = uc($info2[3]);


my $temp_line = "$main/HGMD/data/tabix_$temp";
#print "$line\n";
#print "$region\n";

` $tabix $gnomad $region > $temp_line`;


open(INPUT1,$temp_line) || die ("$temp_line");
my $AF_max = 0;
my $AC_max=0;
my $AN_max=0;
my $AF = 0;
my $AC=0;
my $AN=0;
my $hom=0;
my $flag_wes=0;
while(my $line1 = <INPUT1>){
my @info1 = split(/\s+/,$line1);
if(($info2[0] eq "$info1[0]") && ($info2[1] == $info1[1])&&(uc($info1[3]) eq $ref)&&(uc($info1[4])eq $alt)){
if($line1 =~ /\;AF_popmax\=(\S+)\;/){
my @AF_max = split(/\;/,$1);
$AF_max = $AF_max[0];
$flag_wes=1;
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

if($line1=~/\;nhomalt\=(\S+)\;/){
my @hom = split(/\;/,$1);
$hom = $hom[0];
}

#print "$freq\n";
#exit;

last;
}
}
}
my $flag_wgs=0;
if($flag_wes == 0){
#my $gnomad_wgs = "/storage/novaseq/backup_jw/gnomad/gnomad.genomes.r2.1.1.sites.vcf.bgz";
my $gnomad_wgs = "/storage/chenlab/Users/junwang/gnomAD/gnomad.genomes.r2.1.1.sites.vcf.bgz";

` $tabix $gnomad_wgs $region > $temp_line`;
open(INPUT1,$temp_line) || die ("$temp_line") ;
while(my $line1 = <INPUT1>){
my @info1 = split(/\s+/,$line1);
if(($info2[0] eq "$info1[0]") && ($info2[1] == $info1[1])&&(uc($info1[3]) eq $ref)&&(uc($info1[4])eq $alt)){
if($line1 =~ /\;AF_popmax\=(\S+)\;/){
my @AF_max = split(/\;/,$1);
$AF_max = $AF_max[0];
$flag_wgs=1;

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

if($line1=~/\;nhomalt\=(\S+)\;/){
my @hom = split(/\;/,$1);
$hom = $hom[0];
}

last;
}
}

}
}
#print OUTPUT "$line\t$max_ac\t$max_freq\t$max_an\t$ac\t$freq\t$an\t$hom\n";
# print OUTPUT "$line\t$AF\t$AC\t$AN\t$AF_max\t$AC_max\t$AN_max\tAF:$AF;AC:$AC;AN:$AN;AF_max:$AF_max;AC_max:$AC_max;AN_max:$AN_max\n";
 print OUTPUT "$line\t$AF\t$AC\t$AN\t$AF_max\t$AC_max\t$AN_max\t$hom\n";

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
