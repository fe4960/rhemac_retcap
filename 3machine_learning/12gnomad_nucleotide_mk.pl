#!/usr/bin/perl -w
use strict;
my $fasta = "/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_10/Macaca_mulatta.Mmul_10.dna.toplevel.fa";
#my $fasta = "/storage/chen/home/jw29/Gript/hg19.fasta";
#my $fasta = "/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_10/Macaca_mulatta.Mmul_10.dna.toplevel.fa";
#my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8";
#my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/variant_table_retcap_new2_rm8_clean";
my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_clinvar_hg19AF";
#####my $file = "monkey/data/database/variant_table_GVCFs.10_retcap2_updated_AF_corrected_vep101_updated_new_gene_clinvar_hg19AF";
####my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/target_gene_with_var_new2_rm8_swiss_hg19AF";

#my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new1_rm8";
open(INPUT,$file);
#<INPUT>;
my $output = $file."_rhemac10_nt";
open(OUTPUT,">$output");
while(my $line = <INPUT>){
chomp $line;
my @info = split(/\t/,$line);
$info[0] =~ s/chr//g;
#if($info[14] ne "." ){
my @coor = split(/\:/,$info[0]);
my $start = $coor[1]-1;
my $end = $coor[1];
print OUTPUT "$coor[0]\t$start\t$end\t$info[0]\n";
#}
}
my $output_fa = $output.".fa";
`bedtools getfasta -fi $fasta  -fo $output_fa -bed $output -name`;
