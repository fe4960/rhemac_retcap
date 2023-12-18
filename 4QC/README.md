##### 1. Compute sequencing coverage for different plates #####

python 1summarize_coverage_plate.py

##### 2. Compute sequencing QC states with bcftools #####

sh 2stat.sh

##### 3. Plot sequencing coverage distribution #####

R 3query.R

##### 4. Identify the overlapped genotype between repeated sequencing of the same rhesus macaque. #####

sh 4compare_gt.sh

sh 4compare_gt_within.sh

##### 5. Plot replicated samples #####

R 5extract_sample.R

R 5extract_sample_withinBatch.R
