#!/bin/sh

(head -n 1 monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_rf13 | awk '{print $_"\tpercentile_ranking"}'  && tail -n+2 monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_rf13 | sort -k 16nr,16nr | awk '{i+=1; print $_"\t"i/6296*100}') > monkey/data/retcap/variant_table_retcap_new2_rm8_corrected_vep101_target_updated_gnomad_clinvar_retnet_screen_simple_score_rf13_percentile


