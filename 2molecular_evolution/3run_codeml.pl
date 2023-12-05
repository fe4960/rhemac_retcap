#!/usr/bin/perl -w
use strict;
my $codeml="/storage/chen/home/jw29/software/paml4.9j/bin/codeml";
my $file = "/storage/chenlab/Users/junwang/monkey/data/retcap/hm_rm_retnet_pair";
my $kaks=$file."_kaks_codeml";
open(OUTPUTt,">$kaks");
#my $kaks=$file."_kaks_codeml";
open(INPUT,$file);
while(my $line = <INPUT>){
chomp $line;
my @info = split(/\s+/,$line);
my @human = split(/\|/,$info[0]);
my @rhemac = split(/\|/,$info[1]);
#my $align = "/storage/chenlab/Users/junwang/monkey/data/retnet/hm_rm_retnet_fasta/$human[0]"."_".$human[1]."_".$rhemac[1]."_DNA.fasta";
my $align = "monkey/data/retcap/hm_rm_retnet_fasta/$human[0]"."_".$human[1]."_".$rhemac[1]."_DNA.fasta";
print "$align\n";
open(INPUT1,$align);
my $line1 = <INPUT1>;
chomp $line1;
my $human = $line1;
$human =~ s/>//g;
my $human_seq = <INPUT1>;
chomp $human_seq;
my @human_seq = split(//,$human_seq);

my $rhemac=<INPUT1>;
chomp $rhemac;
$rhemac =~ s/>//g;
my $rhemac_seq=<INPUT1>;
chomp $rhemac_seq;
my @rhemac_seq = split(//,$rhemac_seq);
my ($new_human_seq, $new_rhemac_seq);
for(my $i=0; $i<=length($human_seq)-1; $i+=3){
my $human_seq_sub=$human_seq[$i].$human_seq[$i+1].$human_seq[$i+2];
my $rhemac_seq_sub=$rhemac_seq[$i].$rhemac_seq[$i+1].$rhemac_seq[$i+2];
if(($human_seq_sub =~ /[\!|\-]/) || ($rhemac_seq_sub =~ /[\!|\-]/)) {#||($human_seq_sub =~ /(TAG|TAA|TGA)/)||($rhemac_seq_sub =~ /(TAG|TAA|TGA)/)){
;
}else{
$new_human_seq .= $human_seq_sub;
$new_rhemac_seq .=$rhemac_seq_sub;
}
}
my $len=length($new_human_seq);
my $codeml_seq = substr($align,0,length($align)-10)."_codeml";
my $codeml_ctl = substr($align,0,length($align)-10)."_codeml.ctl";
my $codeml_rel = substr($align,0,length($align)-10)."_codeml.rel";
my $icode=0;
open(OUTPUT0,">$codeml_seq");
print OUTPUT0 "\t2\t$len\nquery\n$new_human_seq\nhit\n$new_rhemac_seq\n";
open(OUTPUT,">$codeml_ctl");
     my $ctl_text = qq{
    seqfile = $codeml_seq
    treefile = codeml.tree
    outfile = $codeml_rel
    noisy = 0  * 0,1,2,3,9: how much rubbish on the screen
    verbose = 0 * 0: concise; 1: detailed, 2: too much
    runmode = -2
    seqtype = 1
    CodonFreq = 2 
    clock = 0
    model = 0
    NSsites = 0
    icode = $icode
    fix_kappa = 0
    kappa = 2
    fix_omega = 0
    omega = 0.1
    fix_alpha = 1
    alpha = .0
    Malpha = 0
    ncatG = 10
    getSE = 0
    RateAncestor = 0
    method = 0
    Small_Diff = .5e-6
    cleandata =1
};
        print OUTPUT "$ctl_text";
        `$codeml $codeml_ctl`;
        unlink("2ML.dN");
        unlink("2ML.dS");
        unlink("2ML.t");
        unlink("2NG.dN");
        unlink("2NG.dS");
        unlink("2NG.t");
        `tail -n 1 $codeml_rel > temp_codeml_output`;

  open(INPUTt,"temp_codeml_output");
        my $line_codeml = <INPUTt>;
        close INPUTt;
        chomp $line_codeml;
#        open(OUTPUTt,">>$kaks");
        print OUTPUTt  "$human[0]|$human[1]-$rhemac[1]\t$line_codeml\n";
#        close OUTPUTt;
 
}

close OUTPUTt;
