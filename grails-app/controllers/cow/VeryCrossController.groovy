package cow

import cow.LinkedVisHierData

class VeryCrossController {

    def index() {
        render(view: 'very_cross')
    }
    def very_cross() { }
    def feedMeLinkedData(){
        cow.LinkedVisHierData linkedVisHierData = new cow.LinkedVisHierData()
        String assaysSectionJson =  linkedVisHierData.createCombinedListing()
        render (assaysSectionJson)
    }
        def feedMeJson(){
render ("""[
    {
        "assayId": "533",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Ion channel NompC"
        }    }
,
    {
        "assayId": "784",
        "data": {
            "GO_biological_process_term" : "regulation of gene expression",
            "assay_format" : "cell-based format",
            "assay_type" : "protein expression assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "880",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=251",
            "assay_format" : "single protein format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "238",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Regulator of G-protein signaling 4"
        }    }
,
    {
        "assayId": "673",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "whole-cell lysate format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "792",
        "data": {
            "GO_biological_process_term" : "regulation of gene expression",
            "assay_format" : "cell-based format",
            "assay_type" : "protein expression assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "506",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "264",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "fluorescence interference assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "625",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "239",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Regulator of G-protein signaling 8"
        }    }
,
    {
        "assayId": "1064",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=124487323",
            "assay_format" : "biochemical format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "638",
        "data": {
            "GO_biological_process_term" : "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0035613",
            "assay_format" : "cell-based format",
            "assay_type" : "reporter-gene assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "104",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=42741659",
            "assay_format" : "cell-based format",
            "assay_type" : "transporter assay",
            "protein_target" : "Multidrug resistance protein 1"
        }    }
,
    {
        "assayId": "702",
        "data": {
            "GO_biological_process_term" : "regulation of gene expression",
            "assay_format" : "cell-based format",
            "assay_type" : "protein expression assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "134",
        "data": {
            "GO_biological_process_term" : "immunological synapse formation",
            "assay_format" : "cell-based format",
            "assay_type" : "gene-expression assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "102",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=62526033",
            "assay_format" : "cell-based format",
            "assay_type" : "transporter assay",
            "protein_target" : "ATP-binding cassette sub-family G member 2"
        }    }
,
    {
        "assayId": "1081",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=8743",
            "assay_format" : "cell-based format",
            "assay_type" : "cytotoxicity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "637",
        "data": {
            "GO_biological_process_term" : "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0035613",
            "assay_format" : "cell-based format",
            "assay_type" : "reporter-gene assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "897",
        "data": {
            "GO_biological_process_term" : "cell death",
            "assay_format" : "cell-based format",
            "assay_type" : "cytotoxicity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "628",
        "data": {
            "GO_biological_process_term" : "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0048156",
            "assay_format" : "biochemical format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "303",
        "data": {
            "GO_biological_process_term" : "bontoxilysin activity",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "479",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "926",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "925",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "228",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=231632",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Apoptosis regulator Bcl-2"
        }    }
,
    {
        "assayId": "229",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "335",
        "data": {
            "GO_biological_process_term" : "plectin-1",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "263",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Guanine nucleotide-binding protein G(o) subunit alpha"
        }    }
,
    {
        "assayId": "171",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Desmoglein-3"
        }    }
,
    {
        "assayId": "333",
        "data": {
            "GO_biological_process_term" : "PLAP",
            "assay_format" : "single protein format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "223",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=4757840",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Bcl-2-related protein A1"
        }    }
,
    {
        "assayId": "225",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "865",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "reporter-gene assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "556",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "coupled enzyme activity assay",
            "protein_target" : "5-hydroxytryptamine receptor 5A"
        }    }
,
    {
        "assayId": "149",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=148539876",
            "assay_format" : "single protein format",
            "assay_type" : "protein-RNA interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "690",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "binding assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "1045",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "328",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "reporter-gene assay",
            "protein_target" : "Integrin alpha-7"
        }    }
,
    {
        "assayId": "1083",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=901648",
            "assay_format" : "cell-based format",
            "assay_type" : "viability assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "119",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=13177715",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "AP-2 complex subunit beta"
        }    }
,
    {
        "assayId": "120",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "122",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "230",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=7582271",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Induced myeloid leukemia cell differentiation protein Mcl-1"
        }    }
,
    {
        "assayId": "231",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "241",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Regulator of G-protein signaling 19"
        }    }
,
    {
        "assayId": "885",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "77",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "DNA-(apurinic or apyrimidinic site) lyase"
        }    }
,
    {
        "assayId": "110",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "reporter-gene assay",
            "protein_target" : "Hypoxia-inducible factor 1-alpha"
        }    }
,
    {
        "assayId": "698",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "513",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "884",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Protein-arginine deiminase type-4"
        }    }
,
    {
        "assayId": "952",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "1057",
        "data": {
            "GO_biological_process_term" : "positive regulation of NF-kappaB transcription factor activity",
            "assay_format" : "cell-based format",
            "assay_type" : "reporter-gene assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "631",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "whole-cell lysate format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "101",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "175",
        "data": {
            "GO_biological_process_term" : "drug transmembrane transporter activity",
            "assay_format" : "cell-based format",
            "assay_type" : "transporter assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "240",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Regulator of G-protein signaling 7"
        }    }
,
    {
        "assayId": "705",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "binding assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "632",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "1043",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "1034",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "879",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "478",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "323",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "fluorescence interference assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "742",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "tissue-based format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "630",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "549",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "501",
        "data": {
            "GO_biological_process_term" : "negative regulation of protein catabolic process",
            "assay_format" : "cell-based format",
            "assay_type" : "reporter-gene assay",
            "protein_target" : "Wee1-like protein kinase"
        }    }
,
    {
        "assayId": "400",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "coupled enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "169",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=168184763",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "927",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "320",
        "data": {
            "GO_biological_process_term" : "myeloid leukocyte differentiation",
            "assay_format" : "cell-based format",
            "assay_type" : "protein expression assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "535",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Mucolipin-3"
        }    }
,
    {
        "assayId": "460",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "542",
        "data": {
            "GO_biological_process_term" : "regulation of gene expression",
            "assay_format" : "cell-based format",
            "assay_type" : "protein expression assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "242",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Regulator of G-protein signaling 16"
        }    }
,
    {
        "assayId": "634",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "209",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=190938",
            "assay_format" : "single protein format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Ras GTPase-activating protein-binding protein 1"
        }    }
,
    {
        "assayId": "738",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "tissue-based format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "737",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "tissue-based format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "108",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "functional assay",
            "protein_target" : "Pyruvate kinase isozymes M1/M2"
        }    }
,
    {
        "assayId": "208",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=8574038",
            "assay_format" : "single protein format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Ras-related C3 botulinum toxin substrate 1"
        }    }
,
    {
        "assayId": "336",
        "data": {
            "GO_biological_process_term" : "regulation of protein stability",
            "assay_format" : "cell-based format",
            "assay_type" : "reporter-gene assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "496",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "binding assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "310",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=21392848",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "668",
        "data": {
            "GO_biological_process_term" : "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=8219",
            "assay_format" : "cell-based format",
            "assay_type" : "cytotoxicity assay",
            "protein_target" : "GTPase HRas"
        }    }
,
    {
        "assayId": "762",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "196",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Integrin beta-1"
        }    }
,
    {
        "assayId": "387",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Delta-type opioid receptor"
        }    }
,
    {
        "assayId": "210",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=46577642",
            "assay_format" : "single protein format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Ras-related protein Rab-2A"
        }    }
,
    {
        "assayId": "183",
        "data": {
            "GO_biological_process_term" : "vacuolar proton-transporting V-type ATPase complex",
            "assay_format" : "cell-based format",
            "assay_type" : "localization assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "151",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "protein complex format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "AP-2 complex subunit beta"
        }    }
,
    {
        "assayId": "401",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=281307097",
            "assay_format" : "biochemical format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "402",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "981",
        "data": {
            "GO_biological_process_term" : "cellular response to oxidative stress",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "1080",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "none",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "1085",
        "data": {
            "GO_biological_process_term" : "activation of cysteine-type endopeptidase activity involved in apoptotic process",
            "assay_format" : "cell-based format",
            "assay_type" : "apoptosis assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "124",
        "data": {
            "GO_biological_process_term" : "receptor internalization",
            "assay_format" : "cell-based format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Beta-2 adrenergic receptor"
        }    }
,
    {
        "assayId": "1044",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "499",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "binding assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "232",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=1572493",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Bcl-2-like protein 2"
        }    }
,
    {
        "assayId": "233",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "717",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "ion-channel assay",
            "protein_target" : "KCNQ3"
        }    }
,
    {
        "assayId": "443",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "whole-cell lysate format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "423",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "coupled enzyme activity assay",
            "protein_target" : "5-hydroxytryptamine receptor 5A"
        }    }
,
    {
        "assayId": "211",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=4757952",
            "assay_format" : "single protein format",
            "assay_type" : "protein-small molecule interaction assay",
            "protein_target" : "Cell division control protein 42 homolog"
        }    }
,
    {
        "assayId": "593",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "Bloom syndrome protein"
        }    }
,
    {
        "assayId": "1023",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=12381848",
            "assay_format" : "single protein format",
            "assay_type" : "coupled enzyme activity assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "522",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "226",
        "data": {
            "GO_biological_process_term" : "http://www.ncbi.nlm.nih.gov/gquery/?term=510901",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Bcl-2-like protein 1"
        }    }
,
    {
        "assayId": "227",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "626",
        "data": {
            "GO_biological_process_term" : "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0048156",
            "assay_format" : "protein complex format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "736",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "635",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "single protein format",
            "assay_type" : "direct enzyme activity assay",
            "protein_target" : "DNA repair protein RAD51 homolog 1"
        }    }
,
    {
        "assayId": "1084",
        "data": {
            "GO_biological_process_term" : "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0042827",
            "assay_format" : "cell-based format",
            "assay_type" : "secreted protein assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "627",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "526",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "none",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "21",
        "data": {
            "GO_biological_process_term" : "cholesterol import",
            "assay_format" : "cell-based format",
            "assay_type" : "transporter assay",
            "protein_target" : "Scavenger receptor class B member 1"
        }    }
,
    {
        "assayId": "388",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "protein-protein interaction assay",
            "protein_target" : "Delta-type opioid receptor"
        }    }
,
    {
        "assayId": "547",
        "data": {
            "GO_biological_process_term" : "regulation of gene expression",
            "assay_format" : "cell-based format",
            "assay_type" : "protein expression assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "191",
        "data": {
            "GO_biological_process_term" : "cellular senescence",
            "assay_format" : "cell-based format",
            "assay_type" : "oxidative stress assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "624",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "cell-based format",
            "assay_type" : "functional assay",
            "protein_target" : "none"
        }    }
,
    {
        "assayId": "580",
        "data": {
            "GO_biological_process_term" : "none",
            "assay_format" : "biochemical format",
            "assay_type" : "coupled enzyme activity assay",
            "protein_target" : "Beta Lactamase"
        }    }

]""")
    }

}
