0. select clinvar variants for the targeted genes
0select_clinvar_variant.py

1. Select swiss variants for the targeted genes
1select_swiss_variant.py

2. Convert clinvar variants in hg19 to rhemac10
2hg19_to_mac10_translate.sh

3. Convert swiss variants in hg19 to rhemac10
3hg19_to_mac10_translate_swiss.sh

4. Annotate hg19 gene annotation for the clinvar variants 
4annotate_clinvar_variant.sh

5. Add variant prediction scores from dbNSPF for clinvar variants
5search_dbNSPF_clinvar_var.sh

6. Annotate hg19 gene annotation for the swiss variants 
6annotate_swiss.sh

7. Add variant prediction scores from dbNSPF for clinvar variants
7search_dbNSPF_swiss_var.sh

8. Extract clinvar variants in targeted regions of targeted genes
8merged_AF_mk.sh

9. Extract swiss variants in targeted regions of targeted genes
9merged_AF_mk_swiss.sh

10. Extract clinvar variants in rhemac10 coordinate
10export_var_mk_clinvar.sh

11. Extract swiss variants in rhemac10 coordinate
11export_var_mk_swiss.sh

12. Get the reference nucleotide in rhemac10
12gnomad_nucleotide_mk.pl

13. Annotate the rhesus macaque allele frequency of swiss variants
13gnomad_reverse_new_origin_swiss_mk.pl

14. Add gnomAD hg19 allele frequency of clinvar pathogenic variants
14gnomad_reverse_new_origin_clinv_patho.pl

15. Annotate the rhesus macaque allele frequency of clinvar variants
15gnomad_reverse_new_origin_clinv_mk.pl

16. Add gnomAD hg19 allele frequency of clinvar variants
16gnomad_reverse_new_origin_clinv.pl

17. Annotate variant scores for clinvar variants
18generate_new_patho.py

18. Train an integrative score with seven machine learning algorithm
19train_missense_score.R

19. Compute HM score with the random forest model for the testset of variants and all the missense variants
20train_missense_score_test_set.R

20. Compute the percent rank of HM score
21perc_rank.sh


