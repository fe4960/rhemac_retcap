1. Filter variants based on QC metrics computed by GATK: QD < 5.0, QUAL < 30.0, FS > 15.0, MQ < 50.0, MQRankSum < -12.5, and ReadPosRankSum < -8.0. 

1GATK_filtering.sh

2. Split multiple alleles into bi-alleles

2split_multiallele.sh

3. Filter variants following the criteria listed in "Quality Control" in the Methods section.

3filter_var.pl

4. LiftOver rhesus macaque variants in rhemac8 to rhemac10 then to hg19, or from rhemac10 to hg19. Also use bcftools to correct and annotate variants. 

5add_mac8_hg19_translate.sh

5add_mac10_hg19_translate.sh

5. Annotate variants in hg19 with ANNOVAR (v. 07/17/2017), dbNSFP (v.3.5a) and HGMD (v.12-20-2016).

6annotate_human_data_run.sh

6. Generate database tables including monkey_table, monkey_variant_geno_table, variant_table, and Allele_frequency_table

7generate_database_table_rm8.pl

7. Export collected rhesus variants in rhemac10

8export_var_new.sh

8. Run ensembl VEP to annotate rhemac10 variants

9run.vep_database.sh
