<?php

$query = $_GET['query'];

$mysqli = mysqli_connect("host", "user", "pass", "db", "3306") or die ("Connection Error");

$test = $mysqli->query("select monkey_variant_id,geneID,REPLACE(monkey_anno,'_variant','') AS monkey_anno,monkey_exon,monkey_cDNA,monkey_aa,human_variant_id,human_chr,human_pos,human_ref,human_alt,hg38_id,hg38_chr,hg38_pos,hg38_ref,hg38_alt,human_var_eff,human_gene,REPLACE(human_anno,'_SNV','') AS human_anno,human_aa,hgmd,ada_score,rf_score,rs_dbSNP,Polyphen,SIFT,REVEL_score,MutationAssessor,CADD from variant where hg38_id='$query' limit 1 ");

$testing=$test->fetch_assoc();
$monkey_gene = $testing["geneID"];
$monkey_anno = $testing["monkey_anno"];
$monkey_cDNA = $testing["monkey_cDNA"];
$monkey_aa = $testing["monkey_aa"];
$variant = $testing["monkey_variant_id"];
$human_variant = $testing["human_variant_id"];
$human_chr = $testing["human_chr"];
$human_pos = $testing["human_pos"];
$human_ref = $testing["human_ref"];
$human_alt = $testing["human_alt"];
$hg38 = $testing["hg38_id"];
$hg38_chr = $testing["hg38_chr"];
$hg38_pos = $testing["hg38_pos"];
$hg38_ref = $testing["hg38_ref"];
$hg38_alt = $testing["hg38_alt"];
$human_gene = $testing["human_gene"];
$human_anno = $testing["human_anno"];
$ada = $testing["ada_score"];
$rf = $testing["rf_score"];
$rs_dbSNP = $testing["rs_dbSNP"];
$Polyphen = $testing["Polyphen"];
$SIFT = $testing["SIFT"];
$REVEL = $testing["REVEL_score"];
$MutationAssessor = $testing["MutationAssessor"];
$CADD = $testing["CADD"];


if($variant == null){ 
     include('not_found.html');
}else{

$try = $mysqli->query("select genename from gene where id='$monkey_gene' ");
$trying=$try->fetch_assoc();
$gene = $trying["genename"];

$test1 = $mysqli->query("select variant,Cayo_het,Cayo_hom,CNPRC_het,CNPRC_hom,NEPRC_het,NEPRC_hom,ONPRC_het,ONPRC_hom,SNPRC_het,SNPRC_hom,TNPRC_het,TNPRC_hom,Unknown_het,Unknown_hom,WNPRC_het,WNPRC_hom,YNPRC_het,YNPRC_hom,Cayo_AN,Cayo_AC,LEFT(Cayo_het_GF,8) AS Cayo_het_GF,LEFT(Cayo_hom_GF,8) AS Cayo_hom_GF,LEFT(Cayo_AF,8) AS Cayo_AF,CNPRC_AN,CNPRC_AC,LEFT(CNPRC_het_GF,8) AS CNPRC_het_GF,LEFT(CNPRC_hom_GF,8) AS CNPRC_hom_GF,LEFT(CNPRC_AF,8) AS CNPRC_AF,WNPRC_AN,WNPRC_AC,LEFT(WNPRC_het_GF,8) AS WNPRC_het_GF,LEFT(WNPRC_hom_GF,8) AS WNPRC_hom_GF,LEFT(WNPRC_AF,8) AS WNPRC_AF,NEPRC_AN,NEPRC_AC,LEFT(NEPRC_het_GF,8) AS NEPRC_het_GF,LEFT(NEPRC_hom_GF,8) AS NEPRC_hom_GF,LEFT(NEPRC_AF,8) AS NEPRC_AF,YNPRC_AN,YNPRC_AC,LEFT(YNPRC_het_GF,8) AS YNPRC_het_GF,LEFT(YNPRC_hom_GF,8) AS YNPRC_hom_GF,LEFT(YNPRC_AF,8) AS YNPRC_AF,ONPRC_AN,ONPRC_AC,LEFT(ONPRC_het_GF,8) AS ONPRC_het_GF,LEFT(ONPRC_hom_GF,8) AS ONPRC_hom_GF,LEFT(ONPRC_AF,8) AS ONPRC_AF,SNPRC_AN,SNPRC_AC,LEFT(SNPRC_het_GF,8) AS SNPRC_het_GF,LEFT(SNPRC_hom_GF,8) AS SNPRC_hom_GF,LEFT(SNPRC_AF,8) AS SNPRC_AF,TNPRC_AN,TNPRC_AC,LEFT(TNPRC_het_GF,8) AS TNPRC_het_GF,LEFT(TNPRC_hom_GF,8) AS TNPRC_hom_GF,LEFT(TNPRC_AF,8) AS TNPRC_AF,Unknown_AN,Unknown_AC,LEFT(Unknown_het_GF,8) AS Unknown_het_GF,LEFT(Unknown_hom_GF,8) AS Unknown_hom_GF,LEFT(Unknown_AF,8) AS Unknown_AF,AN,AC,hom,het,LEFT(het_GF,8) AS het_GF,LEFT(hom_GF,8) AS hom_GF,LEFT(AF,8) AS AF from AF where variant='$variant' ");
$testing1=$test1->fetch_assoc();
$AN = $testing1["AN"];
$AC = $testing1["AC"];
$hom = $testing1["hom"];
$het = $testing1["het"];
$hom_GF = $testing1["hom_GF"];
$het_GF = $testing1["het_GF"];
$AF = $testing1["AF"];

$Cayo_AN = $testing1["Cayo_AN"];
$Cayo_AC = $testing1["Cayo_AC"];
$Cayo_hom = $testing1["Cayo_hom"];
$Cayo_het = $testing1["Cayo_het"];
$Cayo_hom_GF = $testing1["Cayo_hom_GF"];
$Cayo_het_GF = $testing1["Cayo_het_GF"];
$Cayo_AF = $testing1["Cayo_AF"];

$CNPRC_AN = $testing1["CNPRC_AN"];
$CNPRC_AC = $testing1["CNPRC_AC"];
$CNPRC_hom = $testing1["CNPRC_hom"];
$CNPRC_het = $testing1["CNPRC_het"];
$CNPRC_hom_GF = $testing1["CNPRC_hom_GF"];
$CNPRC_het_GF = $testing1["CNPRC_het_GF"];
$CNPRC_AF = $testing1["CNPRC_AF"];

$NEPRC_AN = $testing1["NEPRC_AN"];
$NEPRC_AC = $testing1["NEPRC_AC"];
$NEPRC_hom = $testing1["NEPRC_hom"];
$NEPRC_het = $testing1["NEPRC_het"];
$NEPRC_hom_GF = $testing1["NEPRC_hom_GF"];
$NEPRC_het_GF = $testing1["NEPRC_het_GF"];
$NEPRC_AF = $testing1["NEPRC_AF"];

$ONPRC_AN = $testing1["ONPRC_AN"];
$ONPRC_AC = $testing1["ONPRC_AC"];
$ONPRC_hom = $testing1["ONPRC_hom"];
$ONPRC_het = $testing1["ONPRC_het"];
$ONPRC_hom_GF = $testing1["ONPRC_hom_GF"];
$ONPRC_het_GF = $testing1["ONPRC_het_GF"];
$ONPRC_AF = $testing1["ONPRC_AF"];

$SNPRC_AN = $testing1["SNPRC_AN"];
$SNPRC_AC = $testing1["SNPRC_AC"];
$SNPRC_hom = $testing1["SNPRC_hom"];
$SNPRC_het = $testing1["SNPRC_het"];
$SNPRC_hom_GF = $testing1["SNPRC_hom_GF"];
$SNPRC_het_GF = $testing1["SNPRC_het_GF"];
$SNPRC_AF = $testing1["SNPRC_AF"];

$TNPRC_AN = $testing1["TNPRC_AN"];
$TNPRC_AC = $testing1["TNPRC_AC"];
$TNPRC_hom = $testing1["TNPRC_hom"];
$TNPRC_het = $testing1["TNPRC_het"];
$TNPRC_hom_GF = $testing1["TNPRC_hom_GF"];
$TNPRC_het_GF = $testing1["TNPRC_het_GF"];
$TNPRC_AF = $testing1["TNPRC_AF"];

$Unknown_AN = $testing1["Unknown_AN"];
$Unknown_AC = $testing1["Unknown_AC"];
$Unknown_hom = $testing1["Unknown_hom"];
$Unknown_het = $testing1["Unknown_het"];
$Unknown_hom_GF = $testing1["Unknown_hom_GF"];
$Unknown_het_GF = $testing1["Unknown_het_GF"];
$Unknown_AF = $testing1["Unknown_AF"];

$WNPRC_AN = $testing1["WNPRC_AN"];
$WNPRC_AC = $testing1["WNPRC_AC"];
$WNPRC_hom = $testing1["WNPRC_hom"];
$WNPRC_het = $testing1["WNPRC_het"];
$WNPRC_hom_GF = $testing1["WNPRC_hom_GF"];
$WNPRC_het_GF = $testing1["WNPRC_het_GF"];
$WNPRC_AF = $testing1["WNPRC_AF"];

$YNPRC_AN = $testing1["YNPRC_AN"];
$YNPRC_AC = $testing1["YNPRC_AC"];
$YNPRC_hom = $testing1["YNPRC_hom"];
$YNPRC_het = $testing1["YNPRC_het"];
$YNPRC_hom_GF = $testing1["YNPRC_hom_GF"];
$YNPRC_het_GF = $testing1["YNPRC_het_GF"];
$YNPRC_AF = $testing1["YNPRC_AF"];


echo <<<LABEL

<head>
    <title>mCED</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="static/images/icon.png" type="image/x-icon">
    <link rel="icon" href="static/images/icon.png" type="image/x-icon">
    <link rel=stylesheet type=text/css href="static/typeaheadjs.css">
    <link rel=stylesheet type=text/css href="static/css/font-awesome.min.css">
    <script type="text/javascript" src="static/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="static/bootstrap.min.js"></script>
    <script type="text/javascript" src="static/typeahead.bundle.min.js"></script>

    <script type="text/javascript" src="static/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="static/jquery.tablesorter.pager.js"></script>
    <link rel=stylesheet type=text/css href="static/theme.default.css">
    <script type="text/javascript" src="static/underscore-min.js"></script>

    <link rel=stylesheet type=text/css href="static/bootstrap.min.css">
    <link rel=stylesheet type=text/css href="static/style.css">
    <script type="text/javascript" src="static/d3.v3.min.js"></script>
    <script type="text/javascript" src="static/index.js"></script>
    <script type="text/javascript" src="static/exac.js"></script>
    <script type="text/javascript">
        number_of_samples = 2123;
        release_number = 1.0;
        number_of_samples_full = 2123;
        $(document).ready(function() {
            $('.number_samples').html(Number(number_of_samples).toLocaleString('en'));
            $('.number_samples_full').html(Number(number_of_samples_full).toLocaleString('en'));
            $('.release_number').html(Number(release_number).toLocaleString('en'));
        });
        $(function() {
            var bestPictures = new Bloodhound({
              datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
              queryTokenizer: Bloodhound.tokenizers.whitespace,
              remote: '/autocomplete/%QUERY'
            });

            bestPictures.initialize();

            $('.awesomebar').typeahead(
                {
                    autoselect: true,
                },
                {
                    name: 'best-pictures',
                    displayKey: 'value',
                    source: bestPictures.ttAdapter(),
                }
            );
            $('.awesomebar').bind('typeahead:selected', function(obj, datum) {
                window.location.href = '/awesome?query=' + datum.value;
            });
        });
    </script>
</head>
<body>
<nav class="navbar navbar-default" role="navigation" style="background: #103173;">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle pull-right" data-toggle="collapse" data-target="#navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            
            <a class="navbar-brand" href="index.html" style="color: white; font-weight: bold; float: left; font-size: 15px;">mCED</a>
            
            <div class="col-xs-5" id="navbar_form_container">
                <form action="variant.php" class="navbar-form" role="search">
                    <div class="form-group" id="navbar-awesomebar">
                        <input type="submit" style="display: none;"/>
                        <input id="navbar-searchbox-input" name="query" class="form-control awesomebar" type="text" placeholder="Variant: chr:pos:ref:alt"/>
                        <input type="submit" style="position: absolute; left: -9999px"/>
                    </div>
                </form>
            </div>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="about.html" style="color: white; font-weight: bold;">About</a></li>
                <li><a href="downloads.html" style="color: white; font-weight: bold;">Downloads</a></li>
                <li><a href="terms.html" style="color: white; font-weight: bold;">Terms</a></li>
                <li><a href="contact.html" style="color: white; font-weight: bold;">Contact</a></li>
                <li><a href="faq.html" style="color: white; font-weight: bold;">FAQ</a></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>


    <style>
    .d3_graph {
        font: 10px sans-serif;
    }

    .bar rect {
        fill: steelblue;
        shape-rendering: crispEdges;
    }

    .bar text {
        fill: #fff;
    }

    .axis path, .axis line {
        fill: none;
        stroke: #000;
        shape-rendering: crispEdges;
    }
    </style>
     <script>
        var af_buckets = [0.0001, 0.0002, 0.0005, 0.001, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1];
        function get_af_bucket_text(bin) {
            if (bin == 'singleton' || bin == 'doubleton') {
                return 'This is the site quality distribution for all ' + bin + 's in Iranome.';
            } else if (bin == '0.0001') {
                return 'This is the site quality distribution for all variants with AF < ' + bin + ' in Iranome.';
            } else {
                return 'This is the site quality distribution for all variants with ' + af_buckets[af_buckets.indexOf(parseFloat(bin)) - 1] + ' < AF < ' + bin + ' in Iranome.';
            }
        }

        $(document).ready(function() {
            $('.frequency_display_buttons').change(function() {
                $('.frequency_displays').hide();
                var v = $(this).attr('id').replace('_button', '');
                $('#' + v + '_container').show();
            });
            $('#frequency_table').tablesorter({
                sortList: [[7,1], [0,0]]
            });

            //if (window.variant != null && 'genotype_depths' in window.variant) {
			if (window.variant != null) {
				if ('genotype_depths' in window.variant) {
                	draw_quality_histogram(window.variant.genotype_depths[1], '#quality_display_container', false);
				}
                $('.quality_display_buttons').change(function() {
                    var v = $(this).attr('id').replace('_button', '');
                    var f = $('.quality_full_site_buttons.active').attr('id') == 'variant_site_button' ? 0 : 1;
                    draw_quality_histogram(window.variant[v][f], '#quality_display_container', false);
                });
                $('.quality_full_site_buttons').change(function() {
                    var v = $('.quality_display_buttons.active').attr('id').replace('_button', '');
                    var f = $(this).attr('id') == 'variant_site_button' ? 0 : 1;
                    draw_quality_histogram(window.variant[v][f], '#quality_display_container', false);
                });

                // Quality metric histograms

                var data = _.zip(_.map(window.metrics['Site Quality']['mids'], Math.exp), window.metrics['Site Quality']['hist']);
                console.log(data);
                draw_quality_histogram(data, '#quality_metric_container', true);
                var bin = window.metrics['Site Quality']['metric'].split('_')[1];
                $('#site_quality_note').html(get_af_bucket_text(bin));
                var pos = $('#quality_metric_select').val().split(': ')[1];
                add_line_to_quality_histogram(data, pos, '#quality_metric_container', true);
                $('#quality_metric_select').change(function() {
                    var v = $(this).val().split(': ');
                    var log = false;
                    var data;
                    if (v[0] == 'Site Quality') {
                        data = _.zip(_.map(window.metrics[v[0]]['mids'], Math.exp), window.metrics[v[0]]['hist']);
                        log = true;
                        var bin = window.metrics['Site Quality']['metric'].split('_')[1];
                        $('#site_quality_note').html(get_af_bucket_text(bin));
                    } else {
                        data = _.zip(window.metrics[v[0]]['mids'], window.metrics[v[0]]['hist']);
                        if (v[0] == 'Strand Bias-Fisher\'s (FS)') 
                            $('#site_quality_note').html('Phred-scaled p-value using Fisher\'s exact test to detect strand bias. This distribution represents all variants in iranome.');
                        else if (v[0] == 'BaseQRankSum')
                            $('#site_quality_note').html('Z-score from Wilcoxon rank sum test of Alt Vs. Ref base qualities. This distribution represents all variants in iranome.');
                        else if (v[0] == 'MQRankSum')
                            $('#site_quality_note').html('Z-score From Wilcoxon rank sum test of Alt vs. Ref read mapping qualities. This distribution represents all variants in iranome.');
                        else if (v[0] == 'Mapping Qual (MQ)')
                            $('#site_quality_note').html('RMS Mapping Quality. This distribution represents all variants in iranome.');
                        else if (v[0] == 'Quality by Depth (QD)')
                            $('#site_quality_note').html('Variant Confidence/Quality by Depth. This distribution represents all variants in iranome.');
                        else if (v[0] == 'Read Depth (DP)')
                            $('#site_quality_note').html('Approximate read depth; some reads may have been filtered. This distribution represents all variants in iranome.');
                        else if (v[0] == 'ReadPosRankSum')
                            $('#site_quality_note').html('Z-score from Wilcoxon rank sum test of Alt vs. Ref read position bias. This distribution represents all variants in iranome.');
                        else
                            $('#site_quality_note').html('');
                    }
                    draw_quality_histogram(data, '#quality_metric_container', log);
                    add_line_to_quality_histogram(data, v[1], '#quality_metric_container', log);
                });
            } else {
                $('#quality_metrics_container').hide();

            }
        });
    </script>

    <div class="container">
        <h1><span class="hidden-xs">Variant: </span>
LABEL;
echo"$variant";
echo <<<LABEL
        </h1>
        <hr/>
        
            <div class="row">
                <div class="col-md-6">
                    <dl class="dl-horizontal">
                        <dt>Genome build</dt>
                        <dd> Mmul_10/rhemac10</dd>
                        <dt>Variant Type</dt>
                        <dd> 
LABEL;
echo"$monkey_anno";

echo                        "</dd>";
echo                        "<dt>Allele Frequency</dt>";
echo                        "<dd> ".$AF."</dd>";
echo                        "<dt>Allele Count</dt>";
echo                        "<dd> ".$AC."/".$AN."</dd>";
echo                        "<dt>Gene</dt>";
echo                        "<dd> ".'<a href="gene.php?query='.$gene.'">'.$gene.'</a>'." in database</dd>";
echo <<<LABEL
                        <dt>Annotations</dt>
                    <dd>
                        <div class="dropdown">
                            <button data-toggle="dropdown" class="btn btn-inverse btn-xs dropdown-toggle">
                                cDNA and AA change
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-inverse" role="menu" aria-labelledby="external_ref_dropdown">
                                <li role="presentation">
                                    <a role="menuitem" tabindex="-1" target="_blank">
                                        cDNA change: 
LABEL;
echo"$monkey_cDNA";
echo <<<LABEL
                                    </a>
                                </li>
                                <li role="presentation">
                                    <a role="menuitem" tabindex="-1" target="_blank">
                                        AA change: 
LABEL;
echo"$monkey_aa";
echo <<<LABEL
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </dd>

                        <dt>= = = = = = = = </dt>
                        <dd>= = = = = = = =</dd>
                        <dt>Lift to GRCh37/hg19</dt>
LABEL;
echo                        "<dd> ".$human_variant."</dd>";
echo                        "<dt>UCSC hg19</dt>";
echo                        "<dd> ";
echo                            '<a href="https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position=chr'.$human_chr.'%3A'.$human_pos.'-'.$human_pos.'">'.$human_variant.' <i class="fa fa-external-link"></i></a>';
echo                        "</dd>";
echo                        "<dt>gnomAD v2.1.1</dt>";
echo                        "<dd> ";
echo                        '<a href="http://gnomad.broadinstitute.org/variant/'.$human_chr.'-'.$human_pos.'-'.$human_ref.'-'.$human_alt.'?dataset=gnomad_r2_1" target="_blank">'.$human_variant.' in gnomAD <i class="fa fa-external-link"></i></a>';
echo                        "</dd>";

echo                        "<dt>- - - - - - - - </dt>";
echo                        "<dd>- - - - - - - -</dd>";

echo                        "<dt>Lift to GRCh38/hg38</dt>";
echo                        "<dd> ".$hg38."</dd>";
echo                        "<dt>UCSC hg38</dt>";
echo                        "<dd> ";
echo                            '<a href="https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position=chr'.$hg38_chr.'%3A'.$hg38_pos.'-'.$hg38_pos.'">'.$hg38.' <i class="fa fa-external-link"></i></a>';
echo                        "</dd>";
echo                        "<dt>gnomAD v4.0.0</dt>";
echo                        "<dd> ";
echo                        '<a href="http://gnomad.broadinstitute.org/variant/'.$hg38_chr.'-'.$hg38_pos.'-'.$hg38_ref.'-'.$hg38_alt.'" target="_blank">'.$hg38.' in gnomAD <i class="fa fa-external-link"></i></a>';
echo                        "</dd>";

echo                        "<dt>- - - - - - - - </dt>";
echo                        "<dd>- - - - - - - -</dd>";

echo                        "<dt>Human Variant Type</dt>";
echo                        "<dd> ".$human_anno."</dd>";
echo                        "<dt>Human Gene</dt>";
echo                        "<dd> ".'<a href="https://gnomad.broadinstitute.org/gene/'.$human_gene.'">'.$human_gene.'</a>'." in gnomAD</dd>";
echo                        "<dt>dbSNP</dt>";
echo                        "<dd> ".'<a href="http://www.ncbi.nlm.nih.gov/projects/SNP/snp_ref.cgi?rs='.$rs_dbSNP.'">'.$rs_dbSNP.' <i class="fa fa-external-link"></i>'."</a></dd>";

echo                        "<dt>ClinVar</dt>";
echo                        "<dd> ";
echo                            '<a href="http://www.ncbi.nlm.nih.gov/clinvar?term='.$rs_dbSNP.'" target="_blank">'.$rs_dbSNP.' in Clinvar <i class="fa fa-external-link"></i></a>';
echo                        "</dd>";

echo                        "<dt>Ensembl</dt>";
echo                        "<dd> ";
echo			        '<a href="http://grch37.ensembl.org/Homo_sapiens/Variation/Explore?db=core;v='.$rs_dbSNP.'" target="_blank">'.$rs_dbSNP.' in Ensembl <i class="fa fa-external-link"></i></a>';  
echo                        "</dd>";

echo <<<LABEL
                    </dl>
                </div>
                <div class="col-md-6">
                
                <div class="section_header" style="margin-left: -15px;">Effect Predictor for 
LABEL;
echo"$human_variant";
echo <<<LABEL
 (hg19)</div>
                <table id="annotate_table" class="tablesorter tablesorter-default" role="grid">
        	                <thead> <tr> <th>Metric</th> <th>Prediction</th></tr></thead>
        	                <tbody>
        	                    
        	                        <tr>
        	                            <td>SIFT Pred (C)</td>
LABEL;

echo        	                            "<td>".$SIFT."</td>";
echo        	                        "</tr>";
        	                    
echo        	                        "<tr>";
echo        	                            "<td>Polyphen2 HVAR Pred (C)</td>";
echo        	                            "<td>".$Polyphen."</td>";
echo        	                        "</tr>";
        	                    
echo        	                        "<tr>";
echo        	                           "<td>REVEL score (C)</td>";
echo        	                            "<td>".$REVEL."</td>";
echo        	                        "</tr>";
        	                    
echo        	                        "<tr>";
echo        	                            "<td>MutationAssessor Pred (C)</td>";
echo        	                            "<td>".$MutationAssessor."</td>";
echo        	                        "</tr>";
        	                    
echo        	                        "<tr>";
echo        	                            "<td>CADD Score (Phred Scale)</td>";
echo        	                            "<td>".$CADD."</td>";
echo        	                        "</tr>";
        	                    
echo        	                        "<tr>";
echo        	                            "<td>Ada Score</td>";
echo        	                            "<td>".$ada."</td>";
echo        	                        "</tr>";
        	                    
echo        	                        "<tr>";
echo        	                            "<td>RF Score</td>";
echo        	                            "<td>".$rf."</td>";
echo        	                        "</tr>";
echo <<<LABEL

        	                </tbody>
        	                <tfoot> </tfoot>
        	            </table>


                </div>
            </div>
            <hr/>
        



		<div class="row">

			<div id="frequency_info_container">
                <div class="section_header">Population Frequencies</div>
                <div id="frequency_table_container" class="frequency_displays">
                    
                    <table id="frequency_table">
                        <thead>
                            <tr>
                                <th data-tooltip="Name of the colony">Colony ID</th>
                                <th data-tooltip="Counts of each alternate allele for each site across all samples">Allele Count</th>
                                <th data-tooltip="Total number of observed alleles in called genotypes">Allele Number</th>
                                
                                    <th data-tooltip="Number of homozygous non-reference genotypes across all samples">Number of Homozygotes</th>
									<th data-tooltip="Number of heterozygous genotypes across all samples">Number of Heterozygotes</th>
									<th data-tooltip="Homozygous genotype frequencies across all samples">Homozygous Genotype Freq.</th>
									<th data-tooltip="Heterozygous genotype frequencies across all samples">Heterozygous Genotype Freq.</th>
                                
                                <th data-tooltip="Frequencies of each allele for each site across all samples">Allele Frequency</th>
                            </tr>
                        </thead>
                        <tbody>
LABEL;
                         
echo                                "<tr>";
echo                                    "<td>";
echo                                       '<a href="genotype.php?variant='.$variant.'&colony=CNPRC">CNPRC</a>';
echo                                    "</td>";                                    
echo                                    "<td>".$CNPRC_AC."</td>";
echo                                    "<td>".$CNPRC_AN."</td>";
echo                                    "<td>".$CNPRC_hom."</td>";
echo                                    "<td>".$CNPRC_het."</td>";
echo                                    "<td>".$CNPRC_hom_GF."</td>";
echo                                    "<td>".$CNPRC_het_GF."</td>";
echo                                    "<td>".$CNPRC_AF."</td>";                                 
echo                                "</tr>";
echo                                "<tr>";
echo                                    "<td>";
echo                                       '<a href="genotype.php?variant='.$variant.'&colony=Cayo">Cayo</a>';
echo                                    "</td>";                                    
echo                                    "<td>".$Cayo_AC."</td>";
echo                                    "<td>".$Cayo_AN."</td>";
echo                                    "<td>".$Cayo_hom."</td>";
echo                                    "<td>".$Cayo_het."</td>";
echo                                    "<td>".$Cayo_hom_GF."</td>";
echo                                    "<td>".$Cayo_het_GF."</td>";
echo                                    "<td>".$Cayo_AF."</td>";                                 
echo                                "</tr>";
echo                                "<tr>";
echo                                    "<td>";
echo                                       '<a href="genotype.php?variant='.$variant.'&colony=WNPRC">WNPRC</a>';
echo                                    "</td>";                                    
echo                                    "<td>".$WNPRC_AC."</td>";
echo                                    "<td>".$WNPRC_AN."</td>";
echo                                    "<td>".$WNPRC_hom."</td>";
echo                                    "<td>".$WNPRC_het."</td>";
echo                                    "<td>".$WNPRC_hom_GF."</td>";
echo                                    "<td>".$WNPRC_het_GF."</td>";
echo                                    "<td>".$WNPRC_AF."</td>";                                 
echo                                "</tr>";
echo                                "<tr>";
echo                                    "<td>";
echo                                       '<a href="genotype.php?variant='.$variant.'&colony=NEPRC">NEPRC</a>';
echo                                    "</td>";                                    
echo                                    "<td>".$NEPRC_AC."</td>";
echo                                    "<td>".$NEPRC_AN."</td>";
echo                                    "<td>".$NEPRC_hom."</td>";
echo                                    "<td>".$NEPRC_het."</td>";
echo                                    "<td>".$NEPRC_hom_GF."</td>";
echo                                    "<td>".$NEPRC_het_GF."</td>";
echo                                    "<td>".$NEPRC_AF."</td>";                                 
echo                                "</tr>";
echo                                "<tr>";
echo                                    "<td>";
echo                                       '<a href="genotype.php?variant='.$variant.'&colony=YNPRC">YNPRC</a>';
echo                                    "</td>";                                    
echo                                    "<td>".$YNPRC_AC."</td>";
echo                                    "<td>".$YNPRC_AN."</td>";
echo                                    "<td>".$YNPRC_hom."</td>";
echo                                    "<td>".$YNPRC_het."</td>";
echo                                    "<td>".$YNPRC_hom_GF."</td>";
echo                                    "<td>".$YNPRC_het_GF."</td>";
echo                                    "<td>".$YNPRC_AF."</td>";                                 
echo                                "</tr>";
echo                                "<tr>";
echo                                    "<td>";
echo                                       '<a href="genotype.php?variant='.$variant.'&colony=SNPRC">SNPRC</a>';
echo                                    "</td>";                                    
echo                                    "<td>".$SNPRC_AC."</td>";
echo                                    "<td>".$SNPRC_AN."</td>";
echo                                    "<td>".$SNPRC_hom."</td>";
echo                                    "<td>".$SNPRC_het."</td>";
echo                                    "<td>".$SNPRC_hom_GF."</td>";
echo                                    "<td>".$SNPRC_het_GF."</td>";
echo                                    "<td>".$SNPRC_AF."</td>";                                 
echo                                "</tr>";
echo                                "<tr>";
echo                                    "<td>";
echo                                       '<a href="genotype.php?variant='.$variant.'&colony=ONPRC">ONPRC</a>';
echo                                    "</td>";                                    
echo                                    "<td>".$ONPRC_AC."</td>";
echo                                    "<td>".$ONPRC_AN."</td>";
echo                                    "<td>".$ONPRC_hom."</td>";
echo                                    "<td>".$ONPRC_het."</td>";
echo                                    "<td>".$ONPRC_hom_GF."</td>";
echo                                    "<td>".$ONPRC_het_GF."</td>";
echo                                    "<td>".$ONPRC_AF."</td>";                                 
echo                                "</tr>";
echo                                "<tr>";
echo                                    "<td>";
echo                                       '<a href="genotype.php?variant='.$variant.'&colony=TNPRC">TNPRC</a>';
echo                                    "</td>";                                    
echo                                    "<td>".$TNPRC_AC."</td>";
echo                                    "<td>".$TNPRC_AN."</td>";
echo                                    "<td>".$TNPRC_hom."</td>";
echo                                    "<td>".$TNPRC_het."</td>";
echo                                    "<td>".$TNPRC_hom_GF."</td>";
echo                                    "<td>".$TNPRC_het_GF."</td>";
echo                                    "<td>".$TNPRC_AF."</td>";                                 
echo                                "</tr>";
                                
echo                        "</tbody>";
echo                        "<tfoot>";
echo                                "<tr>";
                                
echo                                "<td><b>Total</b></td>";
echo                                "<td><b>".$AC."</b></td>";
echo                                "<td><b>".$AN."</b></td>";
echo                                "<td><b>".$hom."</b></td>";
echo                                "<td><b>".$het."</b></td>";
echo                                "<td><b>".$hom_GF."</b></td>";
echo                                "<td><b>".$het_GF."</b></td>";
echo                                "<td><b>".$AF."</b></td>";
echo <<<LABEL
                  
                            </tr>
                        </tfoot>
                    </table>
                    
                </div>
            </div>

		</div>
    </div>

</body>

LABEL;
}
?>
