# rhemac_retcap
This repository comprises code and analyses for the targeted-sequencing of 1,845 rhesus macaques

#### The code for data analysis is distributed under the MIT License (MIT) ####

## System Requirements ##

### Hardware requirements ###
Runing the analysis code only requires a standard computer with sufficient RAM to support in-memory operations.

### Software requirements ###

#### OS Requirements ####
The analysis is supported for Linux. The package has been tested on the following systems: Linux x86_64

#### Package Dependencies ####
R 4.0.0

python3.8

jdk1.8.0_121

GATK 4.0.0.0

PLINK v1.90b5.2

liftOver from UCSC genome browser

bcftools 1.17

macse_v0.9b1.jar 

paml4.9j

ensembl-vep v.101

ANNOVAR v. 07/17/2017 

dbNSFP v.3.5a

HGMD (v.12-20-2016) 

ClinVar (v20230710)

The gnomAD database (v2.1.1)

caret_6.0-93 R package

cvAUC_1.1.4 R package

### Installation Guide:

#### Install from Github ####
git clone https://github.com/fe4960/rhemac_retcap.git

### Detailed analysis step ###
See README.md in each sub folder

### The test dataset ###
The test dataset, a vcf file, is in "test_data" folder.

