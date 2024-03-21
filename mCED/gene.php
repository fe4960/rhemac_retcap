<?php

$query = $_GET['query'];

$mysqli = mysqli_connect("host", "user", "pass", "db", "3306") or die ("Connection Error");

$test1 = $mysqli->query("select DISTINCT id,region,genename,transcript from gene where id='$query' or genename='$query' limit 1");
$testing1=$test1->fetch_assoc();
$gene = $testing1["genename"];
$reg = $testing1["region"];
$ens = $testing1["id"];

if($ens == null){
     include('not_found.html');
}else{

$test2 = $mysqli->query("select id,region,genename,transcript from gene where genename='$gene' ");
$test3 = $mysqli->query("select v.monkey_variant_id,v.geneID,REPLACE(v.monkey_anno,'_variant','') AS monkey_anno,v.monkey_cDNA,v.hg38_id,v.human_variant_id,REPLACE(v.human_anno,'_SNV','') AS human_anno,v.human_aa,REPLACE(v.flag,'_reference','') AS flag,v.gnomad,LEFT(a.AF,8) AS AF from variant as v inner join AF as a on v.monkey_variant_id=a.variant inner join gene as g on v.geneID=g.genename where g.genename='$gene' ");
$test4 = $mysqli->query("select transcript from gene where genename='$gene' ");
$test5 = $mysqli->query("select count(v.monkey_variant_id) from variant as v inner join gene as g on v.geneID=g.genename where g.genename='$gene' ");
$testing5=$test5->fetch_assoc();
$VN = $testing5["count(v.monkey_variant_id)"];



echo <<<LABEL

<head>
    <title>mCED</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="static/images/icon.png" type="image/x-icon">
    <link rel="icon" href="static/images/icon.png" type="image/x-icon">
    <link rel="stylesheet" type=text/css href="static/typeaheadjs.css">
    <link rel="stylesheet" type=text/css href="static/css/font-awesome.min.css">
<!--    <script type="text/javascript" src="static/jquery-1.11.1.min.js"></script> 
    <script type="text/javascript" src="static/bootstrap.min.js"></script>
-->    <script type="text/javascript" src="static/typeahead.bundle.min.js"></script>

    <script type="text/javascript" src="static/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="static/jquery.tablesorter.pager.js"></script>
    <link rel=stylesheet type=text/css href="static/theme.default.css">
    <script type="text/javascript" src="static/underscore-min.js"></script>
    
<!--    <link rel=stylesheet type=text/css href="static/bootstrap.min.css">
-->
    <link rel=stylesheet type=text/css href="static/css/bootstrap.min.css">
    <link rel=stylesheet type=text/css href="static/style.css">
    <script type="text/javascript" src="static/d3.v3.min.js"></script>
    <script type="text/javascript" src="static/index.js"></script>
    <script type="text/javascript" src="static/exac.js"></script> 
    <script type="text/javascript">
    
        number_of_samples = ;
        release_number = 1.0;
        number_of_samples_full = ;
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
                window.location.href = 'awesome?query=' + datum.value;
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
                <form action="gene.php" class="navbar-form" role="search">
                    <div class="form-group" id="navbar-awesomebar">
                        <input type="submit" style="display: none;"/>
                        <input id="navbar-searchbox-input" name="query" class="form-control awesomebar" type="text" placeholder="Gene or Ensembl ID"/>
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
    .table td, .table th {
        font-size: 12px;
    }
    </style>
 
    <div class="container-fluid">
        <div class="col-md-10 col-xs-offset-1 col-md-offset-1">
            <h1>Gene: 
LABEL;
echo"$gene";
echo <<<LABEL
            </h1>
            <hr/>
        </div>
        <div class="row">

            <div class="col-md-4  col-xs-10 col-xs-offset-1 col-md-offset-0">
                <dl class="dl-horizontal">
                    
                       <dt>Genome build</dt>
                       <dd>Mmul_10/rhemac10</dd>
                      
                       <dt>
LABEL;
echo"$gene";
echo <<<LABEL
                       </dt>
                       <dd>
                          <div class="dropdown">
                            <button data-toggle="dropdown" class="btn btn-inverse btn-xs dropdown-toggle">
                                Ensembl ID(s) and Region(s)
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-inverse">
                                
LABEL;
					while ($testing2=$test2->fetch_assoc()) {
                                            $ensemblID = $testing2["id"];
                                            $region = $testing2["region"];
                        echo'<li role="presentation">';
      			        echo '<a role="menuitem" tabindex="-1" target="_blank">'.$ensemblID.": ".$region."</a>";
      			        echo "</li>";
      		         }

echo <<<LABEL
                            </ul>
                        </div>

                       </dd>

LABEL;
echo                    "<dt>Number of variants</dt>";
echo                    "<dd>".$VN."</dd>";

echo                    '<dt class="hidden-xs">UCSC Browser</dt>';
echo                    '<dd class="hidden-xs">';
echo                        '<a href="http://genome.ucsc.edu/cgi-bin/hgTracks?hgsid=1205636921_iXfGyhSy6RHJiSFLnA1wOap7BKca&org=Rhesus&db=rheMac10&position='.$ens.'" target="_blank">'.$reg;
echo                            ' <i class="fa fa-external-link"></i>';
echo                        "</a>";
echo                    "</dd>";

echo                    '<dt class="hidden-xs">Ensembl</dt>';
echo                    '<dd class="hidden-xs">';
echo                        '<a href="https://uswest.ensembl.org/Macaca_mulatta/Gene/Summary?db=core;g='.$ens.'" target="_blank">'.$ens;
echo                            ' <i class="fa fa-external-link"></i>';
echo                        "</a>";
echo                    "</dd>";

echo                    '<dt class="hidden-xs">GeneCards</dt>';
echo                    '<dd class="hidden-xs">Human ';
echo                        '<a href="http://www.genecards.org/cgi-bin/carddisp.pl?gene='.$gene.'" target="_blank">'.$gene.' <i class="fa fa-external-link"></i></a>';
echo                    "</dd>";

echo                    "<dt>OMIM</dt>";
echo                    '<dd>Human <a href="https://omim.org/search?index=entry&start=1&limit=10&sort=score+desc%2C+prefix_sort+desc&search='.$gene.'" target="_blank">'.$gene.' <i class="fa fa-external-link"></i></a>';
echo                    "</dd>";
echo <<<LABEL

                    <dt>Other</dt>
                    <dd>
                        <div class="dropdown">
                            <button data-toggle="dropdown" class="btn btn-inverse btn-xs dropdown-toggle">
                                External References
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-inverse" role="menu" aria-labelledby="external_ref_dropdown">

LABEL;
echo                                '<li role="presentation">';
echo                                    '<a role="menuitem" tabindex="-1" href="http://www.ncbi.nlm.nih.gov/pubmed?term='.$gene.'" target="_blank">';
echo                                        'PubMed Search <i class="fa fa-external-link"></i>';
echo                                    "</a>";
echo                                "</li>";
echo                                '<li role="presentation">';
echo                                    '<a role="menuitem" tabindex="-1" href="http://www.wikigenes.org/?search='.$gene.'" target="_blank">';
echo                                        'Wikigenes <i class="fa fa-external-link"></i>';
echo                                    "</a>";
echo                                "</li>";
echo                                '<li role="presentation">';
echo                                    '<a role="menuitem" tabindex="-1" href="http://www.gtexportal.org/home/gene/'.$gene.'" target="_blank">';
echo                                        'GTEx (Expression) <i class="fa fa-external-link"></i>';
echo                                    "</a>";
echo                                "</li>";
echo                                '<li role="presentation">';
echo                                    '<a role="menuitem" tabindex="-1" href="http://cancer.sanger.ac.uk/cosmic/gene/analysis?genome=37&ln='.$gene.'" target="_blank">';
echo                                        'COSMIC <i class="fa fa-external-link"></i>';
echo                                    "</a>";
echo                                "</li>";
echo                                '<li role="presentation">';
echo                                    '<a role="menuitem" tabindex="-1" href="http://ghr.nlm.nih.gov/gene/'.$gene.'" target="_blank">';
echo                                        'Genetics Home Reference <i class="fa fa-external-link"></i>';
echo                                    "</a>";
echo                                "</li>";
echo                                '<li role="presentation">';
echo                                    '<a role="menuitem" tabindex="-1" href="http://en.wikipedia.org/wiki/'.$gene.'" target="_blank">';
echo                                        'Wikipedia <i class="fa fa-external-link"></i>';
echo                                    "</a>";
echo                                "</li>";
echo <<<LABEL
                            </ul>
                        </div>
                    </dd>
                </dl>
            </div>

            <div class="col-md-1 hidden-xs">
                <div class="dropdown">
                   <button data-toggle="dropdown" class="btn btn-inverse btn-xs dropdown-toggle">
                        Transcripts
                        <span class="caret"></span>
                    </button>
                            
                   <ul class="dropdown-menu" role="menu" aria-labelledby="transcript_dropdown">
LABEL;
                                        while ($testing4=$test4->fetch_assoc()) {
                                            $transcript = $testing4["transcript"];
                        echo'<li role="presentation">';
                                echo '<a role="menuitem" tabindex="-1" target="_blank">'.$transcript."</a>";
                                echo "</li>";
                         }

echo <<<LABEL
            </div>
        </div>
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <h4>Variants across the gene</h4>
    <div id="igvDiv" style="padding-top: 50px;padding-bottom: 20px; height: auto"></div>


<script type="module">

    import igv from "./dist/igv.esm.min.js"

    function drawTrianglerect(context, x, y, w, h) {
        let n = Math.floor(w / h)
        let p = (w % h) / 2

        context.clearRect(x, y, w, h)
        context.fillRect(x, y, w, h / 2)

        for (var i = 0; i < n; i++) {
            drawTriangle(context, p + x + (i) * h, y, h, h)
        }

    }

    function drawTriangle(context, x, y, w, h) {
        // context.clearRect(x, y, w, h)

        context.beginPath()
        context.moveTo(x, y)
        context.lineTo(x + w / 2, y + h)
        context.lineTo(x + w, y)
        context.closePath()
        context.fill()
    }

    function drawCirclerect(context, x, y, w, h) {
        let n = Math.floor(w / h)
        let p = (w % h) / 2

        context.clearRect(x, y, w, h)
        context.fillRect(x, y, w, h / 2)

        for (var i = 0; i < n; i++) {
            drawCircle(context, p + x + (i) * h, y, h, h)
        }

    }


    function drawCircle(context, x, y, w, h) {
        // context.clearRect(x, y, w, h)

        context.beginPath()
        context.arc(x + w / 2, y + h / 2, h / 2, 0, 2 * Math.PI)
        context.fill()
    }

    function drawRoundrect(context, x, y, w, h) {
        let radius = 5
        context.clearRect(x, y, w, h)
        context.beginPath()
        context.moveTo(x + radius, y)
        context.lineTo(x + w - radius, y)
        context.quadraticCurveTo(x + w, y, x + w, y + radius)
        context.lineTo(x + w, y + h - radius)
        context.quadraticCurveTo(x + w, y + h, x + w - radius, y + h)
        context.lineTo(x + radius, y + h)
        context.quadraticCurveTo(x, y + h, x, y + h - radius)
        context.lineTo(x, y + radius)
        context.quadraticCurveTo(x, y, x + radius, y)
        context.closePath()
        // context.stroke()
        context.fill()
    }

    const options =
        {
            locus: "
LABEL;
echo"$reg";
echo <<<LABEL
",
  
	    
     reference: {
       "id": "rhemac10",
       "name": "Macaque",
       "fastaURL": "./data/rheMac10.fa",
       "indexURL": "./data/rheMac10.fa.fai",
       "cytobandURL": "./data/cytoBandIdeo.txt",
       "tracks": [
         {
           "name": "Refseq Genes",
	   "format": "refgene",
           "url": "https://hgdownload.soe.ucsc.edu/goldenPath/rheMac10/database/ncbiRefSeq.txt.gz",
           "indexed": false,
           "removable": false,
           "order": 1000000,
	 },
         {
           "name": "Ensembl Genes",
           "format": "refgene",
           "url": "https://hgdownload.soe.ucsc.edu/goldenPath/rheMac10/database/ensGene.txt.gz",
           "indexed": false,
           "removable": false,
           "order": 1000000,
         }
       ],
     },

            tracks: [
                {
                    url: "./data/variant_table_GVCFs.11_retcap3.vcf.gz",
                    indexURL: "./data/variant_table_GVCFs.11_retcap3.vcf.gz.tbi",
                    name: "mCED",
                    displayMode: "COLLAPSED",
                    colorBy: "Mmul_10 Catergory",
                    colorTable: {
			"missense_variant": "green",
                        "synonymous_variant": "orange",
                        "frameshift_variant": "purple",
                        "stop_gained": "red",
                        "splice_region_variant": "blue",
                        "*": "grey"
                    },
                    visibilityWindow: -1
                }

            ]
        }

    const igvDiv = document.getElementById("igvDiv")

    igv.createBrowser(igvDiv, options)

        .then(function (browser) {

        })
</script>



    <div class="row">
    <div id="gene_plot">
    <span class="hidden-xs">
    </span>

</div>
                    
                </div>
								<div class="row">
									<div class="col-xs-12">
										<div class="clearfix">
											<div class="pull-right tableTools-container"></div>
										</div>
										<div class="table-header">
											Filter by:   
											<span id="variant_selectors_container">
       <div class="btn-group">
          <button data-toggle="dropdown" class="btn btn-inverse btn-xs dropdown-toggle">
              Macaque variant type
              <span class="ace-icon fa fa-caret-down icon-on-right"></span>
          </button>

LABEL;
echo            '<ul class="dropdown-menu dropdown-inverse">';
echo              '<li>';
echo                '<a href="gene.php?query='.$gene.'">all</a>';             
echo              '</li>';

echo              '<li>';
echo                '<a href="gene_filter.php?query='.$gene.'&typ1=missense_variant&typ2=all&fla=all">missense</a>';                                                                                                       
echo              '</li>';

echo              '<li>';
echo                '<a href="gene_filter.php?query='.$gene.'&typ1=synonymous_variant&typ2=all&fla=all">synonymous</a>';
echo              '</li>';
echo            '</ul>';

echo <<<LABEL
       </div><!-- /.btn-group -->

       <div class="btn-group">
          <button data-toggle="dropdown" class="btn btn-inverse btn-xs dropdown-toggle">
              Human variant type
              <span class="ace-icon fa fa-caret-down icon-on-right"></span>
          </button>

LABEL;
echo            '<ul class="dropdown-menu dropdown-inverse">';
echo              '<li>';
echo                '<a href="gene.php?query='.$gene.'">all</a>';                                  
echo              '</li>';

echo              '<li>';
echo                '<a href="gene_filter.php?query='.$gene.'&typ2=nonsynonymous_SNV&typ1=all&fla=all">nonsynonymous</a>';
echo              '</li>';

echo              '<li>';
echo                '<a href="gene_filter.php?query='.$gene.'&typ2=synonymous_SNV&typ1=all&fla=all">synonymous</a>';
echo              '</li>';
echo            '</ul>';

echo <<<LABEL
       </div><!-- /.btn-group -->

       <div class="btn-group">
          <button data-toggle="dropdown" class="btn btn-inverse btn-xs dropdown-toggle">
              Flag
              <span class="ace-icon fa fa-caret-down icon-on-right"></span>
          </button>

LABEL;
echo            '<ul class="dropdown-menu dropdown-inverse">';
echo              '<li>';
echo                '<a href="gene.php?query='.$gene.'">all</a>';                                  
echo              '</li>';

echo              '<li>';
echo                '<a href="gene_filter.php?query='.$gene.'&fla=PASS&typ2=all&typ1=all">pass</a>';
echo              '</li>';

echo              '<li>';
echo                '<a href="gene_filter.php?query='.$gene.'&fla=hg19_reference_mismatch&typ2=all&typ1=all">hg19 mismatch</a>';
echo              '</li>';

echo              '<li>';
echo                '<a href="gene_filter.php?query='.$gene.'&fla=rhemac10_reference_mismatch&typ2=all&typ1=all">rhemac10 mismatch</a>';
echo              '</li>';
echo            '</ul>';

echo <<<LABEL
       </div><!-- /.btn-group -->
</span>

</div>


										<div>
											<table id="dynamic-table" class="table table-striped table-bordered table-hover table-sm">
												<thead>
													<tr>
														<th data-tooltip="chromosome:position:reference:alternate">Variant<span class="caret"></span></th>
														<th data-tooltip="chromosome:position:reference:alternate lift to hg19">Human Variant (hg19)<span class="caret"></span></th>
                                                                                                                <th data-tooltip="chromosome:position:reference:alternate lift to hg38">Human Variant (hg38)<span class="caret"></span></th>
														<th data-tooltip="alternate allele frequency">Allele Frequency<span class="caret"></span></th>
                                                                                                                <th data-tooltip="alternate allele frequency for Human in GnomAD">GnomAD AF<span class="caret"></span></th>
														<th data-tooltip="Variant Effect Predictor (VEP) &#xa; annotation using Gencode 81.&#xa; Worst across all transcripts of this gene.">Annotation&#xa;(rhemac10)<span class="caret"></span></th>
														<th data-tooltip="Variant Effect Predictor (VEP) &#xa; annotation using Gencode 81.&#xa; Worst across all transcripts of this gene.">Annotation&#xa;(hg19)<span class="caret"></span></th>
														<th data-tooltip="HGVS annotation (protein change &#xa; or transcript change for splice variants &#xa; otherwise blank)">Consequence&#xa;(rhemac10)<span class="caret"></span></th>
														<th data-tooltip="HGVS annotation (protein change &#xa; or transcript change for splice variants &#xa; otherwise blank)">Consequence&#xa;(hg19)<span class="caret"></span></th>
														<th>Flag<span class="caret"></span></th>
													</tr>
												</thead>

												<tbody>
LABEL;
					while ($testing3=$test3->fetch_assoc()) {
                                            $monkeyID = $testing3["monkey_variant_id"];
					    $humanID = $testing3["human_variant_id"];
					    $hg38ID = $testing3["hg38_id"];
                                            $AF = $testing3["AF"];
                                            $gnomad = $testing3["gnomad"];
                                            $monkey_anno = $testing3["monkey_anno"];
                                            $human_anno = $testing3["human_anno"];
                                            $monkey_cDNA = $testing3["monkey_cDNA"];
                                            $human_aa = $testing3["human_aa"];
                                            $flag = $testing3["flag"];


      			        echo "<tr>";
                                echo "<td class='hidden-xs'>".'<a href="variant.php?query='.$monkeyID.'">'.$monkeyID."</a></td>";
				echo "<td class='hidden-xs'>".$humanID."</td>";
				echo "<td class='hidden-xs'>".$hg38ID."</td>";
                                echo "<td class='hidden-xs'>".$AF."</td>";
                                echo "<td class='hidden-xs'>".$gnomad."</td>";
                                echo "<td class='hidden-xs'>".$monkey_anno."</td>";
                                echo "<td class='hidden-xs'>".$human_anno."</td>";
                                echo "<td class='hidden-xs'>".$monkey_cDNA."</td>"; 
                                echo "<td class='hidden-xs'>".$human_aa."</td>";  
                                echo "<td class='hidden-xs'>".$flag."</td>";     
      		        	echo "</tr>";
      		         }

echo <<<LABEL
                                                        
												</tbody>
											</table>
										</div>
									</div>
								</div>
		<script src="static/js/jquery-2.1.4.min.js"></script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/jquery.dataTables.min.js"></script>
		<script src="static/js/jquery.dataTables.bootstrap.min.js"></script>
		<script src="static/js/dataTables.buttons.min.js"></script>
		<script src="static/js/buttons.flash.min.js"></script>
		<script src="static/js/buttons.html5.min.js"></script>
		<script src="static/js/buttons.print.min.js"></script>
		<script src="static/js/buttons.colVis.min.js"></script>
		<script src="static/js/dataTables.select.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>


 <script>
 function variant_colors(d) {
     if (d.category == 'lof_variant') {
        return '#cd2932';
     } else if (d.category == 'missense_variant') {
         return '#a96500';
     } else if (d.category == 'synonymous_variant') {
         return '#157e28';
     }
 }

    $('.consequence_display_buttons, #filtered_checkbox').change(function () {
        setTimeout(function() {
            update_variants();
            refresh_links();
        }, 10);
    });

 </script>



		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			jQuery(function($) {
				//initiate dataTables plugin
				var myTable = 
				$('#dynamic-table')
				.wrap("<div class='dataTables_borderWrap' />")   //if you are applying horizontal scrolling (sScrollX)
				.DataTable( {
					bAutoWidth: false,
					"aoColumns": [
					  { "bSortable": true },
					  null, null, null, null, null, null, null,null,
					  { "bSortable": true }
					],
					"aaSorting": [],
					
					
					//"bProcessing": true,
			        //"bServerSide": true,
			        //"sAjaxSource": "http://127.0.0.1/table.php"	,
			
					//,
					//"sScrollY": "400px",
					//"bPaginate": false,
			
					//"sScrollX": "100%",
					//"sScrollXInner": "120%",
					//"bScrollCollapse": true,
					//Note: if you are applying horizontal scrolling (sScrollX) on a ".table-bordered"
					//you may want to wrap the table inside a "div.dataTables_borderWrap" element
			
					//"iDisplayLength": 50
			
			
					select: {
						style: 'multi'
					}
			    } );
			
				
				
				$.fn.dataTable.Buttons.defaults.dom.container.className = 'dt-buttons btn-overlap btn-group btn-overlap';
				
				new $.fn.dataTable.Buttons( myTable, {
					buttons: [
					  {
						"extend": "copy",
						"text": "<i class='fa fa-copy bigger-110 pink'></i> <span class='hidden'>Copy to clipboard</span>",
						"className": "btn btn-white btn-primary btn-bold"
					  },
					  {
						"extend": "csv",
						"text": "<i class='fa fa-database bigger-110 orange'></i> <span class='hidden'>Export to CSV</span>",
						"className": "btn btn-white btn-primary btn-bold"
					  },
					  {
						"extend": "excel",
						"text": "<i class='fa fa-file-excel-o bigger-110 green'></i> <span class='hidden'>Export to Excel</span>",
						"className": "btn btn-white btn-primary btn-bold"
					  },
					  {
						"extend": "pdf",
						"text": "<i class='fa fa-file-pdf-o bigger-110 red'></i> <span class='hidden'>Export to PDF</span>",
						"className": "btn btn-white btn-primary btn-bold"
					  },
					  {
						"extend": "print",
						"text": "<i class='fa fa-print bigger-110 grey'></i> <span class='hidden'>Print</span>",
						"className": "btn btn-white btn-primary btn-bold",
						autoPrint: false,
						message: 'This print was produced using the Print button for DataTable'
					  }		  
					]
				} );
				myTable.buttons().container().appendTo( $('.tableTools-container') );
				
				//style the message box
				var defaultCopyAction = myTable.button(1).action();
				myTable.button(1).action(function (e, dt, button, config) {
					defaultCopyAction(e, dt, button, config);
					$('.dt-button-info').addClass('gritter-item-wrapper gritter-info gritter-center white');
				});
				
				
				var defaultColvisAction = myTable.button(0).action();
				myTable.button(0).action(function (e, dt, button, config) {
					
					defaultColvisAction(e, dt, button, config);
					
					
					if($('.dt-button-collection > .dropdown-menu').length == 0) {
						$('.dt-button-collection')
						.wrapInner('<ul class="dropdown-menu dropdown-light dropdown-caret dropdown-caret" />')
						.find('a').attr('href', '#').wrap("<li />")
					}
					$('.dt-button-collection').appendTo('.tableTools-container .dt-buttons')
				});
			
				////
			
				setTimeout(function() {
					$($('.tableTools-container')).find('a.dt-button').each(function() {
						var div = $(this).find(' > div').first();
						if(div.length == 1) div.tooltip({container: 'body', title: div.parent().text()});
						else $(this).tooltip({container: 'body', title: $(this).text()});
					});
				}, 500);
				
				
				
				
				
				myTable.on( 'select', function ( e, dt, type, index ) {
					if ( type === 'row' ) {
						$( myTable.row( index ).node() ).find('input:checkbox').prop('checked', true);
					}
				} );
				myTable.on( 'deselect', function ( e, dt, type, index ) {
					if ( type === 'row' ) {
						$( myTable.row( index ).node() ).find('input:checkbox').prop('checked', false);
					}
				} );
			
			
			
			
				/////////////////////////////////
				//table checkboxes
				$('th input[type=checkbox], td input[type=checkbox]').prop('checked', false);
				
				//select/deselect all rows according to table header checkbox
				$('#dynamic-table > thead > tr > th input[type=checkbox], #dynamic-table_wrapper input[type=checkbox]').eq(0).on('click', function(){
					var th_checked = this.checked;//checkbox inside "TH" table header
					
					$('#dynamic-table').find('tbody > tr').each(function(){
						var row = this;
						if(th_checked) myTable.row(row).select();
						else  myTable.row(row).deselect();
					});
				});
				
				//select/deselect a row when the checkbox is checked/unchecked
				$('#dynamic-table').on('click', 'td input[type=checkbox]' , function(){
					var row = $(this).closest('tr').get(0);
					if(this.checked) myTable.row(row).deselect();
					else myTable.row(row).select();
				});
			
			
			
				$(document).on('click', '#dynamic-table .dropdown-toggle', function(e) {
					e.stopImmediatePropagation();
					e.stopPropagation();
					e.preventDefault();
				});
				
				
				
				//And for the first simple table, which doesn't have TableTools or dataTables
				//select/deselect all rows according to table header checkbox
				var active_class = 'active';
				$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
					var th_checked = this.checked;//checkbox inside "TH" table header
					
					$(this).closest('table').find('tbody > tr').each(function(){
						var row = this;
						if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
						else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
					});
				});
				
			
				
			
				/********************************/
				//add tooltip for small view action buttons in dropdown menu
				$('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
				
				//tooltip placement on right or left
				
				
				
				
				/***************/
				$('.show-details-btn').on('click', function(e) {
					e.preventDefault();
					$(this).closest('tr').next().toggleClass('open');
					$(this).find(ace.vars['.icon']).toggleClass('fa-angle-double-down').toggleClass('fa-angle-double-up');
				});
				/***************/
				
				
				
				
				
				/**
				//add horizontal scrollbars to a simple table
				$('#simple-table').css({'width':'2000px', 'max-width': 'none'}).wrap('<div style="width: 1000px;" />').parent().ace_scroll(
				  {
					horizontal: true,
					styleClass: 'scroll-top scroll-dark scroll-visible',//show the scrollbars on top(default is bottom)
					size: 2000,
					mouseWheelLock: true
				  }
				).css('padding-top', '12px');
				*/
			
			
			})
		</script>


</body>

LABEL;
}
?>
