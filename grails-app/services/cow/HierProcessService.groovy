package cow

import grails.transaction.Transactional
import groovy.json.JsonSlurper
import org.codehaus.groovy.grails.commons.GrailsApplication

@Transactional
class HierProcessService {


    GrailsApplication grailsApplication

    ///  This will be the structure we recursively descend
    class  HierarchyElement {
        String position
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

    // rread the file in off task
    String readHierarchyFile() {

        String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/elements_ccls_json.txt").file.toString()
        println "Actively loading hhierarchy from file = ${fileLocation}"
        File file = new File(fileLocation)
        int counter = 1
        boolean headerLine = true
        StringBuilder sb = new StringBuilder()
        file.eachLine {
            sb << it
            if (headerLine) {
                headerLine = false
            } else {
                // List<String> fields = it.split('\t')
                println(it)
            }
        }

        return sb.toString()
    }



    // rread the file in off task
    String readNamesFile() {

        String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/fieldNames.json").file.toString()
        println "Actively loading names from file = ${fileLocation}"
        File file = new File(fileLocation)
        int counter = 1
        boolean headerLine = true
        StringBuilder sb = new StringBuilder()
        file.eachLine {
            sb << it
            if (headerLine) {
                headerLine = false
            } else {
                // List<String> fields = it.split('\t')
                println(it)
            }
        }

        return sb.toString()
    }







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
            nextNode = new   HierarchyElement (position:currentPosition)
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


    // pparse the JSON and then walk through every element, adding elements to the tree as we go
    RootedTree convertHierarchyIntoTree() {
        String fileContents = readHierarchyFile()
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




    // pparse the JSON and then walk through every element, adding elements to the tree as we go
    LinkedHashMap<String,String>  convertNamesIntoMap() {
        String fileContents = readNamesFile()
        JsonSlurper slurper = new JsonSlurper()
        def parsedObjects = slurper.parseText(fileContents)
        LinkedHashMap<String,String> map = [:]
        for  (element in parsedObjects)  {
            if (map.containsKey(element.index))  {
                println "Big trouble. We have the duplicated index in the names file = ${element.index}"
            }
            map[element.index]  = element.name
        }
        return map
    }





    String buildJsonRepresentationOfTree ()   {
        RootedTree rootedTree = convertHierarchyIntoTree()
        LinkedHashMap<String,String>  map = convertNamesIntoMap()
    }







}
