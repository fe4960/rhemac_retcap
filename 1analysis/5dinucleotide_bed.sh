#!/bin/sh
fasta="/storage/chen/Pipeline/pipeline/pipeline_restructure/reference/Mmul_8.0.1/Mmul_8.0.1.fa"
output="/storage/chenlab/Users/junwang/monkey/data/retcap/panel.100416.liftover.design.txt"
output1=${output}_4
awk '{print $1"\t"$2"\t"$3"\t"$4}' ${output} | sort -u  | sort -k 1,1 -k 2n,2n -k 3n,3n > ${output1}
output2=${output}_merge
bedtools merge -i ${output1} > ${output2}
output_fa="/storage/chenlab/Users/junwang/monkey/data/retcap/panel.100416.liftover.design.txt_fa"
bedtools getfasta -fi $fasta  -fo $output_fa -bed $output2
