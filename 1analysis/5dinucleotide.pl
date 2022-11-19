#!/usr/bin/perl -w
use strict;
my $fasta = "/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_10/Macaca_mulatta.Mmul_10.dna.toplevel.fa";
my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new2_rm8";

#my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/AF_retcap_new1_rm8";
open(INPUT,$file);
<INPUT>;
my $output = $file."_dinu";
open(OUTPUT,">$output");
while(my $line = <INPUT>){
chomp $line;
my @info = split(/\s+/,$line);
if($info[-1] > 0){
my @coor = split(/\:/,$info[0]);
my $start = $coor[1]-1;
my $end = $coor[1]+1;
print OUTPUT "$coor[0]\t$start\t$end\t$info[0]\n";
}
}
my $output_fa = $output.".fa";
`bedtools getfasta -fi $fasta  -fo $output_fa -bed $output -name`;
