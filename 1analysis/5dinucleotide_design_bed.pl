#!/usr/bin/perl -w
use strict;
my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/panel.100416.liftover.design.txt_fa";
open(INPUT,$file);
my $total_len=0;
my $total_cp=0;
while(my $line = <INPUT>){
chomp $line;
if($line !~ /^>/){
my @info =split(//,$line);
for(my $i=0; $i<=$#info-1; $i++){
my $nt = $info[$i].$info[$i+1];
if(($nt eq "CG") || ($nt eq "GC")){
$total_cp++;
}
$total_len++;
}
$total_len++;
}
}
my $prop = $total_cp/$total_len;
print "total_cp:$total_cp\ttotal_len:$total_len\t$prop\n";

