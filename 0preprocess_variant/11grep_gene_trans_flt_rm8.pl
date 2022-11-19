#!/usr/bin/perl -w
use strict;
my $data="monkey/data/database/Macaca_mulatta.Mmul_10.101.gtf";
#my $file="/storage/chen/data_share_folder/Monkey_database/database_files/variant_table_corrected_vep101";
#my $monkey_table="monkey/data/database/monkey_table_GVCFs.9_corrected";
#my $monkey_table="monkey/data/database/monkey_table_GVCFs.10_corrected";
#my $monkey_table="monkey/data/database/monkey_table_GVCFs.10_updated_corrected";
#my $monkey_table="monkey/data/retcap/monkey_table_retcap_corrected";
#my $monkey_table="monkey/data/retcap/monkey_table_retcap_corrected_target";
#my $monkey_table="monkey/data/retcap/monkey_table_retcap_new_corrected_target";
my $monkey_table="monkey/data/retcap/monkey_table_retcap_new2_rm8_corrected_target";

open(INPUT,$monkey_table);
my $monkey_header=<INPUT>;
chomp $monkey_header;
my %monkey;
my $id=1;
while(my $line = <INPUT>){
chomp $line;
my @info = split(/\t/,$line);
#print "$info[0]\n";
#exit;
$monkey{$info[0]}->{ID}=$id;
$monkey{$info[0]}->{line} = $line;
$id++;
}
#my $file = "monkey/data/database/variant_table_GVCFs.9_corrected_vep101";
#my $file = "monkey/data/database/variant_table_GVCFs.10_corrected_vep101";
#my $file = "monkey/data/database/variant_table_GVCFs.10_updated_corrected_vep101";
#my $file = "monkey/data/retcap/variant_table_retcap_corrected_vep101";
#my $file = "monkey/data/retcap/variant_table_retcap_corrected_vep101_target";
#my $file = "monkey/data/retcap/variant_table_retcap_new_corrected_vep101_target";
my $file = "monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target";

open(INPUTvar,$file);
my %var_gene;
<INPUTvar>;
my %var_table;
while(my $line = <INPUTvar>){
chomp $line;
my @info = split(/\t/,$line);
$var_gene{$info[7]}=1;
$var_table{$info[1]}=1;
}
open(INPUT,$data);
#1       ensembl transcript      8231    26653   .       -       .       gene_id "ENSMMUG00000023296"; gene_version "4"; transcript_id "ENSMMUT00000032773"; transcript_version "4"; gene_source "ensembl"; gene_biotype "protein_coding"; transcript_source "ensembl"; transcript_biotype "protein_coding";
my %gene_hash;
#my $output = "monkey/data/database/monkey_gene_table_vep101_genename_filtered";
#my $output1 = "monkey/data/database/monkey_gene_table_vep101_genename_filtered_noStrand";

#my $output = "monkey/data/database/monkey_gene_table_vep101_genename_filtered_GVCFs.9";
#my $output1 = "monkey/data/database/monkey_gene_table_vep101_genename_filtered_noStrand_GVCFs.9";

#my $output = "monkey/data/database/monkey_gene_table_vep101_genename_filtered_GVCFs.10";
#my $output1 = "monkey/data/database/monkey_gene_table_vep101_genename_filtered_noStrand_GVCFs.10";

#my $output = "monkey/data/retcap/monkey_gene_table_vep101_genename_filtered_retcap_updated_target";
#my $output1 = "monkey/data/retcap/monkey_gene_table_vep101_genename_filtered_noStrand_retcap_updated_target";

#my $output = "monkey/data/retcap/monkey_gene_table_vep101_genename_filtered_retcap_updated_target_new";
#my $output1 = "monkey/data/retcap/monkey_gene_table_vep101_genename_filtered_noStrand_retcap_updated_target_new";

my $output = "monkey/data/retcap/monkey_gene_table_vep101_genename_filtered_retcap_updated_target_new2_rm8";
my $output1 = "monkey/data/retcap/monkey_gene_table_vep101_genename_filtered_noStrand_retcap_updated_target_new2_rm8";



#my $output1 = "monkey/data/database/monkey_gene_table_vep101_ensemblname_filtered";
open(OUTPUT,">$output");
open(OUTPUT1,">$output1");
#print OUTPUT "genename\tensembl_genename\n";
print OUTPUT "Ensembl_id\tregion\tgene_name\ttranscripts\tstrand\n";
print OUTPUT1 "Ensembl_id\tregion\tgene_name\ttranscripts\n";


#print OUTPUT "monkey_ensembl_gene_ID\tmonkey_ensembl_gene_region\tmonkey_ensembl_gene_strand\tmonkey_genename\tmonkey_ensembl_transcript_ID\tmonkey_ensembl_transcript_name\tmonkey_ensembl_transcript_region\n";
my %gene;
while(my $line = <INPUT>){
if($line =~ /^#/){
next;
}
chomp $line;
$line =~ s/"//g;
$line =~ s/;//g;
my @info = split(/\t/,$line);
#1       ensembl transcript      72380   80608   .       +       .       gene_id "ENSMMUG00000000634"; gene_version "4"; transcript_id "ENSMMUT00000000912"; transcript_version "4"; gene_name "ZNF692"; gene_source "ensembl"; gene_biotype "protein_coding"; transcript_name "ZNF692-203"; transcript_source "ensembl"; transcript_biotype "protein_coding";

if($info[2] eq "gene"){
my @info1 = split(/\s+/,$info[8]);
my ($gene,$trans);
my $region = "$info[0]:$info[3]-$info[4]";
for(my $i=0; $i<=$#info1; $i++){
if($info1[$i] eq "gene_id"){
$gene = $info1[$i+1];
last;
}
}
$gene_hash{$gene}->{region}=$region;

}elsif($info[2] eq "transcript"){

my @info1 = split(/\s+/,$info[8]);
my ($gene,$trans,$genename,$trans_name)=(".",".",".",".");
my $region = "$info[0]:$info[3]-$info[4]";
for(my $i=0; $i<=$#info1; $i++){
if($info1[$i] eq "gene_id"){
$gene = $info1[$i+1];
#last;
}

if($info1[$i] eq "gene_name"){
$genename = $info1[$i+1];
$gene_hash{$gene}->{genename}=$genename;

}

if($info1[$i] eq "transcript_id"){
$trans = $info1[$i+1];
$gene_hash{$gene}->{trans}->{$trans}=1;

}

if($info1[$i] eq "transcript_name"){
$trans_name = $info1[$i+1];
}



}
#$ensembl{$gene}=$genename;
#$gene_hash{$gene}->{region}=$gene{$gene}->{region};
$gene_hash{$gene}->{str} = $info[6];
#$gene_hash{$genename}->{ensembl}->{$gene}->{str}=$info[6];
#$gene_hash{$genename}->{ensembl}->{$gene}->{trans}->{$trans} = 1;
#$gene_hash{$genename}->{ensembl}->{$gene}->{region} = $gene{$gene}->{region};
}

}

for my $genekey (keys %gene_hash){
my $ensembl_line="";

#for my $genekey (sort keys %{$gene_hash{$key}->{ensembl}}){
#$ensembl_line .= "$genekey,";
if(defined $var_gene{$genekey}){ 
	if(defined $gene_hash{$genekey}->{genename}){
	print OUTPUT "$genekey\t$gene_hash{$genekey}->{region}\t$gene_hash{$genekey}->{genename}\t";
 	print OUTPUT1 "$genekey\t$gene_hash{$genekey}->{region}\t$gene_hash{$genekey}->{genename}\t";
      
 }else{
        print OUTPUT "$genekey\t$gene_hash{$genekey}->{region}\t$genekey\t";
        print OUTPUT1 "$genekey\t$gene_hash{$genekey}->{region}\t$genekey\t";

        }

my $trans_line = "";
#print OUTPUT1 "$genekey\t$gene_hash{$key}->{ensembl}->{$genekey}->{str}\t$gene_hash{$key}->{ensembl}->{$genekey}->{region}\t";
for my $trans_name (sort keys %{$gene_hash{$genekey}->{trans}}){
$trans_line .= "$trans_name,";
}
my $new_trans_line = substr($trans_line,0,length($trans_line)-1);
print OUTPUT "$new_trans_line\t$gene_hash{$genekey}->{str}\n";
print OUTPUT1 "$new_trans_line\n";

}
}
close(OUTPUT); 
close(OUTPUT1);
#my $new_ensembl_line = substr($ensembl_line,0,length($ensembl_line)-1);

#print OUTPUT1 "\n";


#}
#my $genotype_table="/storage/chen/data_share_folder/Monkey_database/database_files/monkey_variant_geno_table_corrected";
#my $genotype_table="monkey/data/database/monkey_variant_geno_table_GVCFs.9";
#my $genotype_table="monkey/data/database/monkey_variant_geno_table_GVCFs.9_corrected";
#my $genotype_table="monkey/data/database/monkey_variant_geno_table_GVCFs.10_corrected";
#my $genotype_table="monkey/data/retcap/monkey_variant_geno_table_retcap_corrected_target";
#my $genotype_table="monkey/data/retcap/monkey_variant_geno_table_retcap_new_corrected_target";
my $genotype_table="monkey/data/retcap/monkey_variant_geno_table_retcap_new2_rm8_corrected_target";

my $output = $genotype_table."_updated";
my %select_monkey;
open(OUTPUT,">$output");
my %variant_hash;
open(INPUTg,$genotype_table);
my $line = <INPUTg>;
my @info = split(/\t/,$line);
print OUTPUT "$info[0]\t$info[1]\t$info[2]\t$info[3]\n";
#print "$info[2]\n";
#exit;
while(my $lineg = <INPUTg>){
chomp $lineg;
my @infog = split(/\t/,$lineg);
if(defined $var_table{$infog[1]}){
#print OUTPUT "$infog[1]\t$infog[2]\t$infog[3]\t$infog[4]\n";
$select_monkey{$infog[2]}=1;
print OUTPUT "$infog[1]\t$monkey{$infog[2]}->{ID}\t$infog[3]\t$infog[4]\n";

$variant_hash{$infog[1]}=$infog[-1];
}
}
close(OUTPUT); 
#my $monkey_table="monkey/data/database/monkey_table_GVCFs.9_corrected";
#my $monkey_table="monkey/data/database/monkey_table_GVCFs.10_corrected";
#my $monkey_table="monkey/data/database/monkey_table_GVCFs.10_updated_corrected";
#my $monkey_table="monkey/data/retcap/monkey_table_retcap_corrected_target";
#my $monkey_table="monkey/data/retcap/monkey_table_retcap_new_corrected_target";
my $monkey_table="monkey/data/retcap/monkey_table_retcap_new2_rm8_corrected_target";

my $output = "$monkey_table"."_updated";
open(OUTPUT,">$output");
print OUTPUT "Index_ID\t$monkey_header\n"; 
for my $monkey ( keys %select_monkey){
print OUTPUT "$monkey{$monkey}->{ID}\t$monkey{$monkey}->{line}\n";
}
close(OUTPUT);
#my $file="/storage/chen/data_share_folder/Monkey_database/database_files/variant_table_corrected_vep101";
#my $file = "monkey/data/database/variant_table_GVCFs.9_corrected_vep101";
#my $file = "monkey/data/database/variant_table_GVCFs.10_corrected_vep101";
#my $file = "monkey/data/retcap/variant_table_retcap_corrected_vep101_target";
#my $file = "monkey/data/retcap/variant_table_retcap_new_corrected_vep101_target";
my $file = "monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target";

my $output = $file."_updated";
open(OUTPUT,">$output");
open(INPUTvar,$file);
my $line = <INPUTvar>;
chomp $line;
print OUTPUT "$line\tflag\n";
while(my $linev = <INPUTvar>){
chomp $linev;
#1       5:48856289:G:A  5       48856289        G       A       WDFY3   ENSMMUG00000021164      ENSMMUT00000029780      synonymous_variant      LOW     exon:24/65      4532_tcG/tcA    1467_S  4:85699689:C:T  4       85699689        C       T       exonic  WDFY3   .       synonymous_SNV  WDFY3:NM_014991:exon27:c.A4485A:p.S1495S        .
#       .       .       .       .       .       .       .       .
my @infov = split(/\t/,$linev);
if($infov[6] eq "."){
if($infov[7] ne "."){
if(defined $gene_hash{$infov[7]}->{genename}){
$infov[6] = $gene_hash{$infov[7]}->{genename};
}else{
$infov[6] = $infov[7];
}
}
}
$infov[12] = "$infov[8]:$infov[12]";
$infov[13] = "$infov[8]:$infov[13]";
my $new_line = join("\t",@infov);
if(defined $variant_hash{$infov[1]}){
#print "$new_line\n$infov[1]\n";
#}
print OUTPUT "$new_line\t$variant_hash{$infov[1]}\n";
}
}
close(OUTPUT); 


