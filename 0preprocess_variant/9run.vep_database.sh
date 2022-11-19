#!/bin/sh
#main=$PWD
main="/stornext/snfs130/ruichen/dmhg/fgi/jwang/monkey/database"
input=${main}/variant_table_GVCFs.10_retcap2_updated_AF_var
output=${main}/variant_table_GVCFs.10_retcap2_updated_AF_var.vep.101

#output=${main}/variant_table_retcap_new_var1.vep.101
1>$main/database.vep.log
2>>$main/database.vep.log
export PATH="/hgsc_software/tabix/tabix-0.2.6/:$PATH"
export PERL5LIB="/stornext/snfs130/ruichen/dmhg/fgi/jwang/software/centos/usr/share/perl5/vendor_perl/:/hgsc_software/tabix/tabix-0.2.6/perl:$PERL5LIB"
/stornext/snfs130/ruichen/dmhg/fgi/jwang/software/ensembl-vep-101/vep  --offline --cache --vcf --dir_cache /stornext/snfs130/ruichen/dmhg/fgi/jwang/software/ensembl-vep-101/vep.cache --no_progress --stats_text --everything --force_overwrite -i $input -o $output -species macaca_mulatta --merged --cache_version 101

