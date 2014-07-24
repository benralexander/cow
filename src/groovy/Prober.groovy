/**
 * Created with IntelliJ IDEA.
 * User: balexand
 * Date: 5/30/14
 * Time: 10:15 AM
 * To change this template use File | Settings | File Templates.
 */

package cbbo;


import groovy.json.JsonSlurper

class Prober {

    static String inputFile = 'MlNumber2_2.csv'
    static String inputFile2 = 'MlNumber4_2.csv'
    static String fileToHoldBiologyIds = 'bio.txt'
    static String fileToHoldUniprotIds = 'uniprotids.txt'
    static LinkedHashMap<Integer,Integer> assaysPerCid = [:]
    static LinkedHashMap<Integer,Integer> targetsPerAssay = [:]

    static TreeSet<Integer> readFromFile(){
        File probeSpreadsheet = new File (inputFile)
        List allLines = probeSpreadsheet.readLines()
        TreeSet<Integer> treeSet = new TreeSet ()
        int count = 0
        int cidExists = 0
        int cidValidated = 0
        int lineCount = 0
        allLines.each{
            lineCount++
            String oneLine = it
            String[] tokens = oneLine.split(',')
            if (tokens[0].startsWith('ML')) {
                if (tokens.size()>5/* &&(lineCount<5)*/){
                    count++
                    if (tokens[4]){
                        cidExists++
                        if (check(tokens[4], treeSet,assaysPerCid,targetsPerAssay)){
                            cidValidated++
                        }
                    }
                }
            }
        }
        println "Line count=${lineCount}, probe count = ${count}, cid field count = ${cidExists}, cid validated count = ${cidValidated}"
        return treeSet
    }



    static TreeSet<Integer> readFromFile2(){
        File probeSpreadsheet = new File (inputFile2)
        List allLines = probeSpreadsheet.readLines()
        TreeSet<Integer> targets = new TreeSet ()
        int count = 0
        int cidExists = 0
        int cidValidated = 0
        int lineCount = 0
        allLines.each{
            lineCount++
            String oneLine = it
            String[] tokens = oneLine.split(',')
            if (tokens[0].startsWith('ML')) {
                if (tokens.size()>1/* &&(lineCount<5)*/){
                    count++
                    if (tokens[1]){
                        cidExists++
                        if (check(tokens[1], targets,assaysPerCid,targetsPerAssay)){
                            cidValidated++
                        }
                    }
                }
            }
        }
        println "Line count=${lineCount}, probe count = ${count}, cid field count = ${cidExists}, cid validated count = ${cidValidated}"
        return targets
    }





    static TreeSet<String> readFromBioIDFile(){
        File probeSpreadsheet = new File (fileToHoldBiologyIds)
        List allLines = probeSpreadsheet.readLines()
        TreeSet<String> retval = new TreeSet ()
        int count = 0
        allLines.each{
            count++
            String oneLine = it
            retval.add oneLine
        }
        return retval
    }






    static boolean  check(String cid,TreeSet<Integer> targets, LinkedHashMap<Integer,Integer> assaysPerCid,LinkedHashMap<Integer,Integer> targetsPerAssay){
        URL url = new URL("http://bard.nih.gov/api/v17.3/compounds/${cid}/summary?expand=true")
        String output = ""
        boolean retval = false
        try {
            InputStream inStream = url.openStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
            def slurper = new JsonSlurper()
            def o = slurper.parse(reader)
            if (o.testedExptdata) {
                assaysPerCid[cid]= o.hitAssays.size()
                java.util.ArrayList hitAssays = o.hitAssays
                for (java.util.HashMap assays in hitAssays) {
                    java.util.ArrayList newTargets = assays.targets
                    if (!assays.containsKey (assays.bardAssayId)){
                        targetsPerAssay[assays.bardAssayId] = newTargets.size()
                    }
                    for (Integer target in newTargets) {
                        targets.add(target)
                    }
                }
                retval = true
            } else {
                println "#######################>>>>>>>>>>>>>>>>no records for cid=${cid}"
            }
        } catch (e) {
            // e.printStackTrace()
            println "#######################no cid=${cid}"
        }
        return retval
    }


    static TreeSet<String>  convertBiologyIdsToUniprotIds(TreeSet<String> treeSetOfBiologyIDs){
        println "retrieveTargetName"
        TreeSet<String> returnValue = new TreeSet ()
        if (treeSetOfBiologyIDs?.size() > 0 ) {
            URL url = new URL("http://bard.nih.gov/api/v17.3/biology?expand=true")
            StringBuilder stringBuilder = new StringBuilder ()
            for ( String biologyID in treeSetOfBiologyIDs ){
                stringBuilder <<  biologyID << ","
            }
            // strip off that trailing ","
            println "stringBuilder=${stringBuilder.toString()}"
            stringBuilder.setLength(stringBuilder.length()-1)
            def queryString = "bids=${stringBuilder.toString()}"
            String output = ""
            try {
                def connection = url.openConnection()
                connection.setRequestMethod("POST")
                connection.doOutput = true
                def writer = new OutputStreamWriter(connection.outputStream)
                writer.write(queryString)
                writer.flush()
                writer.close()
                connection.connect()
                def slurper = new JsonSlurper()
                java.util.ArrayList allRecords = slurper.parseText( connection.content.text)
                for ( def record in allRecords) {
                    HashMap hashMap = record
                    for (def map in hashMap ) {
                        String key = "${map.key}"
                        String value = "${map.value}"
                        if (("${key}"=='extId') &&
                                (!("${value}".contains(':')))) {
                            returnValue.add("${value}")
                        }
                    }
                }
            } catch (e) {
                println "problem converting to uniprot"
            }
        } // more than zero records
        println "completed conversion. Total number of records equals=${returnValue.size()}"
        return returnValue
    }


    static boolean  display(TreeSet<Integer> treeSet){
        File biologyIdFile = new File (fileToHoldBiologyIds)
        Integer [] biologyIds = treeSet.toArray()
        biologyIdFile.withWriter { out ->
            for ( Integer id in biologyIds) {
                out.println id
            }
        }
        println "...biology file writing complete"
        println "::total IDs captured =${biologyIds.size ()}"

        println "::total # of CIDs=${assaysPerCid.size ()}"
        println "::total # of unique assays which hit=${targetsPerAssay.size ()}"
        // count up the assays which hit per compound
        Integer totalNumberOfHitAssays = 0
        for (assayKeyValuePair in  assaysPerCid){
            // println "${assayKeyValuePair.key}"
            totalNumberOfHitAssays += assayKeyValuePair.value
        }
        if (assaysPerCid.size () > 0) {
            println "::total Number Of unique assays=${totalNumberOfHitAssays}, average number of assays that hit per compound=${(totalNumberOfHitAssays/assaysPerCid.size ())}"
        }
        // count up the targets for each assay
        Integer totalNumberOfTargets= 0
        for (targetKeyValuekeyPair in  targetsPerAssay){
            // println "${targetKeyValuekeyPair.key}"
            totalNumberOfTargets += targetKeyValuekeyPair.value
        }
        if (targetsPerAssay.size () > 0) {
            println "::total Number Of unique Targets=${totalNumberOfTargets}, average number of targets per hit assay=${(totalNumberOfTargets/targetsPerAssay.size ())}"
        }

    }






    static TreeSet<String>  record(TreeSet<String> treeSet){
        TreeSet<String> filteredTreeSet = new TreeSet ()
        File unitprotIdFile = new File (fileToHoldUniprotIds)
        String [] unitprotIds = treeSet.toArray()
        print "begin writing file ${fileToHoldUniprotIds} with uniprot IDs..."
        int validatedRecords = 0
        def pattern = ~/[A-Z][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]/
        unitprotIdFile.withWriter { out ->
            for ( String id in unitprotIds) {
                if (pattern.matcher(id)){
                    validatedRecords++
                    filteredTreeSet.add(id)
                    out.println id
                }
            }
        }
        println "...Uniprot file writing complete.  Number of validated records = ${validatedRecords}"
        return filteredTreeSet
    }



    static NodeHolder convertUniprotIdsToNodes(TreeSet<String> treeSet) {
        File unitprotIdFile = new File (fileToHoldUniprotIds)
        NodeHolder nodeHolder = new NodeHolder ()
        int small = 0
        for ( String UniProtId in treeSet){
            small++
            if (small>10000) break
            URL url = new URL("http://bard.nih.gov/api/v17.3/targets/accession/${UniProtId}")
            String output = ""
            boolean retval = false
            try {
                InputStream inStream = url.openStream();
                BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
                def slurper = new JsonSlurper()
                def o = slurper.parse(reader)
                java.util.ArrayList classes = o.classes

                if (classes.size()>0) {
                    for (oneClass in classes){
                        if (oneClass.source=='panther'){
                            nodeHolder.addAnotherNode(oneClass.name,oneClass.description,oneClass.levelIdentifier)
                        } else {
                            println "Non-panther source = ${oneClass.source}"
                        }
                    }
                } else {
                    println "Problem::::::::: ${o.acc} had no associated classes"
                }
            } catch (e) {
                println "problem: no record for node ${UniProtId}."
            }

        }
        return nodeHolder
    }




}


class Node {
    public String name
    public String description
    public  List<Node> children = new ArrayList()
    public Integer mySize  = 1
    public Integer unaccounted = 0
    public Integer color = 1
// constructor
    public Node (  String name, String description ) {
        this.name = name
        this.description = description
    }
    public Node (  Integer nullName, Integer size ) {
        this.name =  "zzull"+nullName.toString()
        this.description = "invisible"
        this.mySize = size
        this.color = 0
    }

    public int bumpSize () {
        mySize++
    }

    public int retriveSize(){
        return mySize
    }

    public int retriveUnaccounted(){
        return unaccounted
    }


    public int retriveColor(){
        return color
    }


} // end class Node




class NodeHolder {

    public  LinkedHashMap<String,Node> nodeFinder  = [:]
    public Node root = null
    public Integer globalCounter = 1

    public NodeHolder(){
        root = new Node ("/","")
        nodeFinder["1."]=root
    }



    public void    createDummyNodes(){
        Integer nullCounter = 0
        for ( Node subNode in root.children) {
            recursivelyBuildDummyChildren(subNode,nullCounter)
        }
    }

    public int recursivelyBuildDummyChildren(Node node,Integer nullCounter) {
        if (node.children.size()>0) {   // if you have no children then you don't need a dummy node
            for ( Node subNode in node.children) {
                nullCounter++
                nullCounter=recursivelyBuildDummyChildren(subNode,nullCounter)
            }
            if (node.unaccounted > 0) {
                nullCounter++
                globalCounter++
                node.children << new Node(globalCounter,node.unaccounted)
            }

        }
        return nullCounter
    }



    /***
     *   Walk the tree and add up all the values underneath each node. Create a field called 'unaccounted'
     *   to hold those values so that we can adjust them later
     */
    public void adjustArcWidthSlices (){
        for ( Node subNode in root.children) {
            addUpEverythingBeneath(subNode)
        }
    }


    public int addUpEverythingBeneath (Node node)  {
        if (node.children.size()==0) {
            return node.mySize+node.unaccounted
        } else {
            int accumulator = 0
            for ( Node subNode in node.children) {
                accumulator += addUpEverythingBeneath(subNode)
            }
            node.unaccounted = node.mySize -  accumulator
            return  node.mySize
        }

    }




    public boolean addAnotherNode ( String nodeName,String nodeDescr, String bringerOfLevels ) {
        List <String> levelBreaker = bringerOfLevels.split(/\./)
        Node currentNode = null
        int depth = 0
        String developingIdentifier = ""
        for ( String level in levelBreaker) {
            // first level gets special handling
            if ( depth == 0 ) {
                if (levelBreaker[0]=="1") {// sanity check --  should always be true
                    currentNode = this.root
                } else {
                    println("Unexpected level root identifier = ${levelBreaker[0]}")
                }
                developingIdentifier += "1."
            } else { // we aren't at the first level
                if (level=="00"){ // node should already be stored by this point
                    break;
                } else {
                    developingIdentifier += (level+".")
                }
                if (!(nodeFinder.containsKey(developingIdentifier))) {
                    nodeFinder[developingIdentifier]=new Node(nodeName,nodeDescr)
                    Node node  =  nodeFinder[developingIdentifier] as Node

                    currentNode.children.add(nodeFinder[developingIdentifier] as Node)
                } else {
                    Node node  =  nodeFinder[developingIdentifier]
                    node.bumpSize()
                    currentNode=node
                }
            }
            depth++
        } // for loop
    }// end method addAnotherNode



    public void printRecursiveDescent (){
        // we can skip the first levels
        // Node root  = /*root.children[0]*/ nodeFinder["1."]
        println "+++++++++++++++ code begins below this line++++++++++++++++++"
        println "var \$data = ["//{\"name\":\"/\", \"children\": ["
        descend(root,1,false)
        println "]"
        println "+++++++++++++++ code ends above this line++++++++++++++++++++"
    }



    public void descend (Node node, int depth,boolean commaNecessary) {
        if ( node ) {
            depth.times{print '  ' }
            print "{\"name\":\"${node.name}\", \"descr\":\"${node.description}\","
            // println node.description
            if (node.children){
                print "\"size\": ${node.retriveSize()},"
                print "\"col\": ${node.retriveColor()},"
//          print "\"unaccounted\": ${node.retriveUnaccounted()},"
                println "\"children\": ["
                int numberOfChildren =  node.children.size()
                int iterationCount = 1
                for (Node subnode in node.children) {
                    descend(subnode, depth+4, ((iterationCount++)<numberOfChildren))
                }
                (depth+2).times{print '  ' }
                print "]}"
                if (commaNecessary) {println ","} else {println()}
            } else {
                //         print "\"unaccounted\": ${node.retriveUnaccounted()},"
                print "\"col\": ${node.retriveColor()},"
                print "\"size\":${node.retriveSize()}}"
                if (commaNecessary) {println ","} else {println()}
            }
        }
    }




} // end class addAnotherNode



