package cow

import grails.converters.JSON

class ProbeController {
    HierProcessService hierProcessService
    def index(){
        redirect (action:"probe_targets")
    }

    def uploadPrep(){

    }

    def upload1() {
        println('got a file')
        println('delete old one')
        new File('./tempStorage1.txt').delete()
        def incomingFile = request.getFile('myFile1')
        if (incomingFile.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'uploadPrep')
            return
        }
        println('type='+incomingFile.getClass().name+'.')
        incomingFile.transferTo(new File('./tempStorage1.txt'))
        println('transferred.')

        render(view: 'uploadPrep',model:[dataFileBased:1])

    }


    def upload2() {
        println('got a file')
        println('delete old one')
        new File('./tempStorage2.txt').delete()
        def incomingFile = request.getFile('myFile2')
        if (incomingFile.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'uploadPrep')
            return
        }
        println('type='+incomingFile.getClass().name+'.')
        incomingFile.transferTo(new File('./tempStorage12.txt'))
        println('transferred.')
        redirect (action:"UploadSunburst")
    }




    def probe_targets() {}
    def HierCat() {
        String treeDescrip = hierProcessService.buildJsonRepresentationOfTree()
        println 'ready to render'

                String x = """[{"name":"/", "descr":"","size": 1,"col": 1,"children": [
                        {"name":"transcription factor", "descr":"A protein required for the regulation of RNA polymerase by specific regulatory sequences in or near a gene.","size": 33,"col": 1,"children": [
                                {"name":"zinc finger transcription factor", "descr":"A transcription factor containing zinc finger domain(s), which is composed of conserved cysteines and histidines co-ordinate with zinc ion(s).  Examples of zinc finger domains are C2H2 zinc finger, C3HC4 zinc finger, CHC2 zinc finger, etc.","col": 1,"size":3},
                                {"name":"transcription cofactor", "descr":"A protein that has no DNA binding domains, but regulates transcription by binding to other transcription factors.","col": 1,"size":3},
                                {"name":"basic helix-loop-helix transcription factor", "descr":"A transcription factor containing helix-loop-helix (HLH) DNA binding domain.","col": 1,"size":1},
                                {"name":"nuclear hormone receptor", "descr":"A receptor of steroid hormones that traverses the nuclear membrane to activate transcription.","col": 1,"size":8},
                                {"name":"zzull2", "descr":"invisible","col": 0,"size":18}
                        ]},
                        {"name":"nucleic acid binding", "descr":"A molecule that binds a nucleic acid.  It can be an enzyme or a binding protein.","size": 37,"col": 1,"children": [
                                {"name":"RNA binding protein", "descr":"A protein that binds RNA and is involved in RNA processing or metabolism.","size": 8,"col": 1,"children": [
                                        {"name":"mRNA processing factor", "descr":"A factor involved in mRNA processing, including capping, polyadenylation and splicing.","size": 3,"col": 1,"children": [
                                                {"name":"mRNA splicing factor", "descr":"A factor involved in mRNA splicing.","col": 1,"size":1},
                                                {"name":"zzull3", "descr":"invisible","col": 0,"size":2}
                                        ]},
                                        {"name":"translation factor", "descr":"A non-ribosomal protein involved in translation initiation, elongation or termination.","size": 2,"col": 1,"children": [
                                                {"name":"translation elongation factor", "descr":"A non-ribosomal protein involved in translation elongation.","col": 1,"size":1},
                                                {"name":"zzull4", "descr":"invisible","col": 0,"size":1}
                                        ]},
                                        {"name":"zzull5", "descr":"invisible","col": 0,"size":3}
                                ]},
                                {"name":"nuclease", "descr":"An enzyme that cleaves the phosphodiester bonds of a nucleic acid.","size": 3,"col": 1,"children": [
                                        {"name":"exodeoxyribonuclease", "descr":"An enzyme that cleaves DNA sequentially from the free ends of a linear nucleic acid substrate.","col": 1,"size":1},
                                        {"name":"endodeoxyribonuclease", "descr":"One of a large group of enzymes that cleaves DNA at an internal position in the chain.","col": 1,"size":1},
                                        {"name":"zzull6", "descr":"invisible","col": 0,"size":1}
                                ]},
                                {"name":"DNA binding protein", "descr":"A protein that has DNA binding domains and binds DNA.  Transcription factors are DNA binding proteins, but they are not included in this category.","size": 4,"col": 1,"children": [
                                        {"name":"chromatin_chromatin-binding protein", "descr":"A non-histone protein that either binds DNA to comprise chromatin or which binds chromatin.","col": 1,"size":1},
                                        {"name":"zzull7", "descr":"invisible","col": 0,"size":3}
                                ]},
                                {"name":"helicase", "descr":"An enzyme that promotes the unwinding of duplex nucleic acids.","size": 2,"col": 1,"children": [
                                        {"name":"DNA helicase", "descr":"An enzyme that promotes the unwinding of duplex DNA.","col": 1,"size":1},
                                        {"name":"zzull8", "descr":"invisible","col": 0,"size":1}
                                ]},
                                {"name":"zzull9", "descr":"invisible","col": 0,"size":20}
                        ]},
                        {"name":"cytoskeletal protein", "descr":"Major constituent of the cytoskeleton found in the cytoplasm of eukaryotic cells. They form a flexible framework for the cell, provide attachment points for organelles and formed bodies, and make communication between parts of the cell possible.","size": 17,"col": 1,"children": [
                                {"name":"actin family cytoskeletal protein", "descr":"A protein that is either actin itself or binds to actin to form the cytoskeleton of the cell.","size": 6,"col": 1,"children": [
                                        {"name":"non-motor actin binding protein", "descr":"An actin binding protein that is not involved in motor function.","col": 1,"size":3},
                                        {"name":"zzull10", "descr":"invisible","col": 0,"size":3}
                                ]},
                                {"name":"microtubule family cytoskeletal protein", "descr":"A protein that is either microtubule itself or binds to microtubule to form the cytoskeleton of the cell.","size": 4,"col": 1,"children": [
                                        {"name":"non-motor microtubule binding protein", "descr":"A nonmotor protein that binds to microtubule cytoskeletal protein.","col": 1,"size":2},
                                        {"name":"zzull11", "descr":"invisible","col": 0,"size":2}
                                ]},
                                {"name":"zzull12", "descr":"invisible","col": 0,"size":7}
                        ]},
                        {"name":"hydrolase", "descr":"Enzymes catalyzing hydrolysis of a variety of bonds, such as esters, glycosides, or peptides.  Protease and phosphatases are separate categories, so they are not included here.","size": 33,"col": 1,"children": [
                                {"name":"protease", "descr":"Enzymes that hydrolyze peptide bonds.","size": 15,"col": 1,"children": [
                                        {"name":"serine protease", "descr":"One of a group of endoproteases from both animal and bacterial sources that share a common reaction mechanism based on formation of an acyl enzyme intermediate on a specific active serine residue.","col": 1,"size":4},
                                        {"name":"cysteine protease", "descr":"Peptide hydrolases that have a cysteine involved in the catalytic process. This group of enzymes is inactivated by sulfhydryl reagents.","col": 1,"size":2},
                                        {"name":"metalloprotease", "descr":"A protease whose catalytic activity requires a transition metal.","col": 1,"size":2},
                                        {"name":"zzull13", "descr":"invisible","col": 0,"size":7}
                                ]},
                                {"name":"lipase", "descr":"Enzymes that catalyze the hydrolysis of fats (monoglycerides, diglycerides and triglycerides) to glycerol and fatty acids. Calcium ions are usually required.","size": 2,"col": 1,"children": [
                                        {"name":"phospholipase", "descr":"Enzymes that hydrolyze ester bonds in phospholipids. They comprise two types: aliphatic esterases (phospholipase A1, A2 and B) that release fatty acids, and phosphodiesterases (types C and D) that release diacyl glycerol or phosphatidic acid respectively.","col": 1,"size":1},
                                        {"name":"zzull14", "descr":"invisible","col": 0,"size":1}
                                ]},
                                {"name":"glucosidase", "descr":"Enzymes that hydrolyze o-glucosyl-compounds.","col": 1,"size":1},
                                {"name":"esterase", "descr":"Enzymes that catalyze the hydrolysis of organic esters to release an alcohol or thiol and acid.","col": 1,"size":3},
                                {"name":"zzull15", "descr":"invisible","col": 0,"size":12}
                        ]},
                        {"name":"transferase", "descr":"Enzymes transferring a group from one compound (donor) to another compound (acceptor).  Kinase is a separate category, so it is not included here.","size": 70,"col": 1,"children": [
                                {"name":"kinase", "descr":"An enzyme that catalyzes the transfer of a phosphate from ATP to a second substrate (EC2.7).","size": 52,"col": 1,"children": [
                                        {"name":"protein kinase", "descr":"An enzyme that catalyzes the transfer of a phosphate from ATP to the hydroxyl side chains on proteins, causing changes in function.","size": 36,"col": 1,"children": [
                                                {"name":"non-receptor serine_threonine protein kinase", "descr":"A soluble protein catalyzing transfer of phosphate from ATP to serine or threonine residue.","col": 1,"size":12},
                                                {"name":"tyrosine protein kinase receptor", "descr":"A protein that has an extracellular ligand binding domain, a single transmembrane domain and an intracellular tyrosine kinase domain that phosphorylates protein tyrosine residues.","col": 1,"size":2},
                                                {"name":"non-receptor tyrosine protein kinase", "descr":"A soluble protein catalyzing transfer of phosphate from ATP to tyrosine residue.","col": 1,"size":8},
                                                {"name":"zzull16", "descr":"invisible","col": 0,"size":14}
                                        ]},
                                        {"name":"carbohydrate kinase", "descr":"An enzyme that catalyzes the phosphorylation of a sugar or carbohydrate.","col": 1,"size":1},
                                        {"name":"zzull17", "descr":"invisible","col": 0,"size":15}
                                ]},
                                {"name":"acetyltransferase", "descr":"An enzyme that catalyzes the transfer of an acetyl group, usually from acetyl coenzyme A, to another compound.","col": 1,"size":1},
                                {"name":"zzull18", "descr":"invisible","col": 0,"size":17}
                        ]},
                        {"name":"ligase", "descr":"A class of enzymes that catalyze the formation of a bond between two substrate molecules, coupled with the hydrolysis of a pyrophosphate bond in ATP or a similar energy donor.","size": 2,"col": 1,"children": [
                                {"name":"ubiquitin-protein ligase", "descr":"An enzyme that couples ubiquitin to protein by a peptide bond between the C-terminal glycine of ubiquitin and a-amino groups of lysine residues in the protein.","col": 1,"size":1},
                                {"name":"zzull19", "descr":"invisible","col": 0,"size":1}
                        ]},
                        {"name":"receptor", "descr":"A molecular structure within a cell or on the cell surface characterized by selective binding of a specific substance and a specific physiologic effect that accompanies the binding.","size": 40,"col": 1,"children": [
                                {"name":"G-protein coupled receptor", "descr":"Cell surface receptors that are coupled to G proteins and have 7 transmembrane spanning domains.","col": 1,"size":13},
                                {"name":"protein kinase receptor", "descr":"A protein that has an extracellular ligand binding domain, a single transmembrane domain and an intracellular kinase domain.","col": 1,"size":2},
                                {"name":"zzull20", "descr":"invisible","col": 0,"size":25}
                        ]},
                        {"name":"signaling molecule", "descr":"A molecule that transduces a signal between cells.","size": 12,"col": 1,"children": [
                                {"name":"growth factor", "descr":"A complex family of biological factors that are produced by the body to control growth, division and maturation of various cell types.","col": 1,"size":2},
                                {"name":"cytokine", "descr":"A small protein or biological factor that is released by cells and have specific effects on cell-cell interaction, communication and behavior of other cells.  It contains interleukins, lymphokines, TNF-alpha and interferons.  Growth factors are generally not included here, although TGF-beta family members, CNTF and LIF are exceptions.","size": 2,"col": 1,"children": [
                                        {"name":"tumor necrosis factor family member", "descr":"A multifunctional proinflammatory cytokine, with effects on lipid metabolism, coagulation, insulin resistance, and endothelial function.","col": 1,"size":1},
                                        {"name":"zzull21", "descr":"invisible","col": 0,"size":1}
                                ]},
                                {"name":"zzull22", "descr":"invisible","col": 0,"size":8}
                        ]},
                        {"name":"enzyme modulator", "descr":"A protein that modulates the activity of a select group of an enzyme such as kinases, phosphatases, protease, and G-proteins.","size": 3,"col": 1,"children": [
                                {"name":"G-protein", "descr":"A GTP-binding protein that is either part of the heterotrimeric G protein class or of the small GTP-binding class.","size": 2,"col": 1,"children": [
                                        {"name":"small GTPase", "descr":"The small G proteins are a diverse group of monomeric GTPases that include ras, rab, rac and rho and that play an important part in regulating many intracellular processes including cytoskeletal organization and secretion.","col": 1,"size":1},
                                        {"name":"zzull23", "descr":"invisible","col": 0,"size":1}
                                ]},
                                {"name":"zzull24", "descr":"invisible","col": 0,"size":1}
                        ]},
                        {"name":"chaperone", "descr":"A cytoplasmic protein that binds to nascent or unfolded polypeptides and ensures correct folding or transport.","size": 3,"col": 1,"children": [
                                {"name":"Hsp90 family chaperone", "descr":"Widely distributed group of conserved heat-shock proteins of average weight 90 kD (HtpG in E. coli). Exact function unknown, but are found associated with steroid hormone receptors and tyrosine kinase oncogene products. May also bind actin and tubulin.","col": 1,"size":1},
                                {"name":"zzull25", "descr":"invisible","col": 0,"size":2}
                        ]},
                        {"name":"cell adhesion molecule", "descr":"A protein that mediates cell-to-cell adhesion.","col": 1,"size":2},
                        {"name":"oxidoreductase", "descr":"An enzyme that catalyzes a redox reaction.","size": 12,"col": 1,"children": [
                                {"name":"dehydrogenase", "descr":"An enzyme that oxidizes a substrate by transferring hydrogen to an acceptor that is either NAD_NADP or a flavin enzyme.","col": 1,"size":2},
                                {"name":"reductase", "descr":"An enzyme that introduces an electron into its substrate from an electron donor.  The reaction is usually coupled with an oxidation reaction.","col": 1,"size":3},
                                {"name":"oxygenase", "descr":"An enzyme that catalyzes the incorporation of molecular oxygen into organic substrates.","col": 1,"size":1},
                                {"name":"oxidase", "descr":"An enzyme that removes an electron from its substrate to an electron acceptor.  The reaction is usually coupled with a reduction reaction.","col": 1,"size":1},
                                {"name":"zzull26", "descr":"invisible","col": 0,"size":5}
                        ]},
                        {"name":"transfer_carrier protein", "descr":"Proteins that carry specific substances in the blood or in the cell. They usually are not involved in transmembrane transport.","size": 2,"col": 1,"children": [
                                {"name":"apolipoprotein", "descr":"The protein component of serum lipoproteins.","col": 1,"size":1},
                                {"name":"zzull27", "descr":"invisible","col": 0,"size":1}
                        ]},
                        {"name":"defense_immunity protein", "descr":"A specific protein substance that is produced to take part in various defense and immune responses of the body.","size": 2,"col": 1,"children": [
                                {"name":"complement component", "descr":"One of 20 distinct serum proteins that is the effector of immune cytolysis.","col": 1,"size":1},
                                {"name":"zzull28", "descr":"invisible","col": 0,"size":1}
                        ]},
                        {"name":"membrane traffic protein", "descr":"A protein that is located on an intracellular vesicle membrane, and is responsible for the docking or fusion of the vesicle to the cytoplasma membrane.","col": 1,"size":2},
                        {"name":"isomerase", "descr":"A class of enzymes that catalyze geometric or structural changes within a molecule to form a single product. The reactions do not involve a net change in the concentrations of compounds other than the substrate and the product.","size": 2,"col": 1,"children": [
                                {"name":"epimerase_racemase", "descr":"Enzymes that catalyze inversion of the configuration around an asymmetric carbon in a substrate having one (racemase) or more (epimerase) center(s) of asymmetry (EC5.1).","col": 1,"size":1},
                                {"name":"zzull29", "descr":"invisible","col": 0,"size":1}
                        ]},
                        {"name":"extracellular matrix protein", "descr":"A protein that is produced and secreted by cells and forms an intricate extracellular meshwork in which cells are embedded to construct tissues.","col": 1,"size":1}
                ]}
        ]
""".toString()

        println 'ready to render2'

     //   render x
        render treeDescrip
    }
    def HierDisplay() {
        render(view: 'HierDisplay')}


    def UploadSunburst() {
        String treeDescrip = hierProcessService.buildJsonRepresentationOfTree()
        render(view: 'UploadSunburst')}



}
