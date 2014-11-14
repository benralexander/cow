package cow

import grails.transaction.Transactional
import groovy.json.JsonSlurper
import org.codehaus.groovy.grails.commons.GrailsApplication

import java.util.regex.Matcher
import java.util.regex.Pattern

@Transactional
class HierProcessService {


    GrailsApplication grailsApplication

    ///  This will be the structure we recursively descend
    class  HierarchyElement {
        String position
        String elementName
        String fullForm
        int  redundancy = 0
        List<HierarchyElement>  children = []
    }


    /// this convenience structure will hold a map that allows us to shoot directly to the element we want
    ///   Also hold the grand root of the whole tree
    class RootedTree {
        LinkedHashMap<String,HierarchyElement> shortcut =  [:]
        HierarchyElement root = new  HierarchyElement ()
    }

    int zzullCount = 0

    /***
     * read a file in from disk which describes every node in the tree, with relative positioning described with a series of paths
     * @return
     */
    String readHierarchyFile() {

      //  String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/elements_ccls_json.txt").file.toString()
      //  String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/20141026_cpd_elements.txt").file.toString()
        String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/20141110_elements_CCLs.txt").file.toString()
        println "Actively loading hhierarchy from file = ${fileLocation}"
        File file = new File(fileLocation)
        int counter = 1
        boolean headerLine = true
        StringBuilder sb = new StringBuilder()
        file.eachLine {
            sb << it
            if (headerLine) {
                headerLine = false
            }
        }

        return sb.toString()
    }

    /***
     * read a file from disk  that describes the names of every element in the graphic
     * @return
     */
    String readNamesFile() {

     //   String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/20141026_fieldNames.json").file.toString()
        String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/20141110_categories_CCLs.txt").file.toString()
        println "Actively loading names from file = ${fileLocation}"
        File file = new File(fileLocation)
        int counter = 1
        boolean headerLine = true
        StringBuilder sb = new StringBuilder()
        file.eachLine {
            sb << it
            if (headerLine) {
                headerLine = false
            }
        }

//        String temp =  sb.toString()
//        String temp2 =  "{\"categories\":"+temp.substring(15)
        return sb.toString()
    }

    public static StringBuffer removeUTFCharacters(String data){
        Pattern p = Pattern.compile("\\\\u(\\p{XDigit}{4})");
        Matcher m = p.matcher(data);
        StringBuffer buf = new StringBuffer(data.length());
        while (m.find()) {
            String ch = String.valueOf((char) Integer.parseInt(m.group(1), 16));
            m.appendReplacement(buf, Matcher.quoteReplacement(ch));
        }
        m.appendTail(buf);
        return buf;
    }



    /***
     *  Add an element  to the tree. Each element is specified with a path containing several numbers. This method
     *  walks down that path element by element. If a path already exists then walked down it. If at any point
     *  the path runs out then add new nodes to the tree.  Use a recursive descent
     *
     * @param treeHolder
     * @param hierarchyElement
     * @param rawForm
     * @param allPositions
     * @return
     */
    RootedTree addToTheTree(RootedTree treeHolder, HierarchyElement hierarchyElement, String rawForm, List<String> allPositions){
        if  ((treeHolder  ==  null )   || (hierarchyElement  ==  null ) ) {
            println("  Big trouble.  One of the incoming pointers expected by the recursive routine  was unexpectedly null ")
        }
        if  ((allPositions  ==  null )   || (allPositions.size ()  < 1) ) {
            println("  Big trouble.  aall positions was emptyl ")
        }
        String  currentPosition = allPositions.head  ()
        List  <String>  remainingPositions = allPositions.tail()
        HierarchyElement nextNode   =  null
        // how do we continue the recursive descent? Identify an existing node or else make a new one if we don't have a match
        for (HierarchyElement childHierarchyElement in hierarchyElement.children)  {
            if   (childHierarchyElement.position == currentPosition) {
                nextNode =   childHierarchyElement
            }
        }
        if  (nextNode   ==  null)  {  // we don't have a matching branch.  Make a new one
            nextNode = new   HierarchyElement (position:currentPosition, redundancy:1)
            hierarchyElement.children << nextNode
        }
        ///  is is a terminal node, or else should we continue the descent
         if (remainingPositions.size ()  < 1)       {   // terminal
             if  (nextNode.fullForm  ==   rawForm)  {
                 nextNode.redundancy++
             }   else   {
                 nextNode.fullForm  =   rawForm
             }
         }  else {
             return addToTheTree( treeHolder,  nextNode,  rawForm, remainingPositions)
         }
        return treeHolder
    }

    /***
     * We need the  trees already exist, and we need a map that can take us from any node to a name. Then recursively
     * to send through the entire tree and in every node  assigned the matching name
     * @param hierarchyElement
     * @param map
     */
    void assignNamesToTree(HierarchyElement hierarchyElement, LinkedHashMap<String,String> map){
        if  (hierarchyElement  ==  null ) {
            println("  Big trouble.  One of the incoming pointers expected by the recursive routine  was unexpectedly null ")
        }
        if  (map  ==  null )  {
            println("  Big trouble.  map was emptyl ")
        }
        // take care of your children first
        for (HierarchyElement childHierarchyElement in hierarchyElement.children)  {
            assignNamesToTree(childHierarchyElement,  map)
        }
        // and now for yourself…
        String  position  =   hierarchyElement.position
        if (!map.containsKey(position))  {
            println "Missing name for index ${hierarchyElement.fullForm?:position}"
        }  else {
            hierarchyElement.elementName  =  map[position]
        }
    }

    /***
     * descend and sum up the value of everyone beneath you. The only nodes whose visits count are the leaves,
     * and they have a field called redundancy. At this point we want to push those values back up the tree so that
     * internal nodes can set redundancy values to match the sum of all their children's redundancy values
     * @param hierarchyElement
     */
    void youAreOnlyAsBigAsYourChildren(HierarchyElement hierarchyElement){
        if  (hierarchyElement  ==  null ) {
            println("  Big trouble.  One of the incoming pointers expected by the recursive routine  was unexpectedly null ")
        }
       // and now for yourself…
        int total =  addItUp ( hierarchyElement )
        println "Grand total of all elements = ${total}"
    }

    /***
     * Here is the method that actually performs the recursive descent
     * @param hierarchyElement
     * @return
     */
    int addItUp(HierarchyElement hierarchyElement)   {
        int accumulator = 0;
        for (HierarchyElement childHierarchyElement in hierarchyElement.children)  {
            accumulator += addItUp(childHierarchyElement)
        }
            hierarchyElement.redundancy  += accumulator;
        return   hierarchyElement.redundancy;
    }

    /***
     * Move down through a series of paths, one per line. In each case add the path to the developing tree
     * @param fileContents
     * @return
     */
    RootedTree convertHierarchyIntoTree(String fileContents) {

        JsonSlurper slurper = new JsonSlurper()
        def parsedObjects = slurper.parseText(fileContents)
        RootedTree rootedTree = new RootedTree  ()
        for  (element in parsedObjects)  {
            String objectPosition =    element.hierarchy
            String  [] individualLevels = objectPosition.split(java.util.regex.Pattern.quote("."))
            rootedTree = addToTheTree(rootedTree, rootedTree.root, objectPosition, individualLevels as List)
       }

        return rootedTree
    }

    /***
     * We have a collection of names and a collection of matching paths. Convert these couples into a map so that
     * we can easily go from a path to a name
     * @return
     */
    LinkedHashMap<String,String>  convertNamesIntoMap() {
        String fileContents = readNamesFile()
        JsonSlurper slurper = new JsonSlurper()
        def parsedObjects = slurper.parseText(fileContents)
        LinkedHashMap<String,String> map = [:]
        for  (element in (parsedObjects))  {
            if (map.containsKey(element.index))  {
                println "Big trouble. We have the duplicated index in the names file = ${element.index}"
            }
            map[element.index]  = element.name
        }
        return map
    }

    /***
     * Assuming that we have a tree all built we now converted into legal JSON in the form of a string
     * that we can send down to the browser
     *
     * @param hierarchyElement
     * @param sb
     * @return
     */
    String constructStringDescriptionForTree(HierarchyElement hierarchyElement,StringBuilder sb){
        if  (hierarchyElement  ==  null ) {
            println("  Big trouble.  One of the incoming pointers expected by the recursive routine  was unexpectedly null ")
        }
         // take care of your children first

        if (hierarchyElement.children.size()>0)  {
            int numberOfChildren  =  hierarchyElement.children.size()
            if (hierarchyElement?.elementName?.startsWith("zzull")){
                sb << """{"name":"${hierarchyElement.elementName}", "descr":"invisible","size": ${hierarchyElement.redundancy},"col": 0,"children": [\n"""
            } else {
                sb << """{"name":"${hierarchyElement.elementName}", "descr":"${hierarchyElement.fullForm?:hierarchyElement.position}","size": ${hierarchyElement.redundancy},"col": 1,"children": [\n"""
            }
            for (int  i = 0 ; i < numberOfChildren; i++  )  {
                HierarchyElement childHierarchyElement =  hierarchyElement.children [i]
                constructStringDescriptionForTree(childHierarchyElement,sb)
                if (i+1 < numberOfChildren) {  //+1
                    sb << """,\n"""
                }  else {
                    sb << """\n"""
                }
            }
            sb << """]}\n"""
        } else {
            if (hierarchyElement.elementName.startsWith("zzull")) {
                sb << """{"name":"${hierarchyElement.elementName}", "descr":"${hierarchyElement.fullForm}","col": 1,"size":${hierarchyElement.redundancy}}"""
            }  else {
                sb << """{"name":"${hierarchyElement.elementName}", "descr":"invisible","col": 0,"size":${hierarchyElement.redundancy}}"""
            }
        }

        return sb.toString()
     }

    /***
     * Add some brackets,, but otherwise serve as a wrapper to call the routine that does all the work, namely constructStringDescriptionForTree
     * @param hierarchyElement
     * @return
     */
    String generateBracketedJson(HierarchyElement hierarchyElement){
        StringBuilder sb = new StringBuilder()
        sb << "[\n"
        constructStringDescriptionForTree (hierarchyElement,sb)
        sb << "]"
        return sb.toString()
    }


     void addInvisibleNodes (HierarchyElement hierarchyElement){
        if  (hierarchyElement  ==  null ) {
            println("  Big trouble.  One of the incoming pointers expected by the recursive routine  was unexpectedly null ")
        }
        // and now for yourself…
        distinguishTheValueOfMyKidsFromMyOwn ( hierarchyElement )
    }

    /***
     * Here is the method that actually performs the recursive descent
     * @param hierarchyElement
     * @return
     */
    int distinguishTheValueOfMyKidsFromMyOwn(HierarchyElement hierarchyElement)   {
        int accumulator = 0;
        for (HierarchyElement childHierarchyElement in hierarchyElement.children)  {
            accumulator += distinguishTheValueOfMyKidsFromMyOwn(childHierarchyElement)
        }
        if(accumulator > hierarchyElement.redundancy) {
            println "This should never happen. Parent ${hierarchyElement.elementName} has value ${hierarchyElement.redundancy}which is less than kids = ${accumulator}"
        } else if(accumulator < hierarchyElement.redundancy)  {

            HierarchyElement temp = new   HierarchyElement ()
            temp.position= "999"
            temp.redundancy =  hierarchyElement.redundancy- accumulator
            temp.elementName = "zzull" + (zzullCount++)
            hierarchyElement.children  << temp
        }
        return hierarchyElement.redundancy
    }




    /***
     * Top-level routine  to do all the work:
     * 1)read in a file describing the hierarchy we want to map
     * 22)Turn that hierarchy into a tree in memory
     * 3)Adjust the numbers so that every parent holds the sum of all his kids
     * 4)Convert a file containing names into a map
     * 5)Assign all those names into our tree
     * 6)and finally turn that tree into a string that we can send to the browser
     * @return
     */
    String buildJsonRepresentationOfTree ()   {
        String fileContents =  readHierarchyFile()
        RootedTree rootedTree = convertHierarchyIntoTree(fileContents)
        youAreOnlyAsBigAsYourChildren (rootedTree.root)
        LinkedHashMap<String,String>  map = convertNamesIntoMap()
        assignNamesToTree(rootedTree.root,  map)
        addInvisibleNodes(rootedTree.root)
        return  generateBracketedJson (rootedTree.root.children[0])
    }







}
