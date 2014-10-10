package cow

import grails.transaction.Transactional
import groovy.json.JsonSlurper
import org.codehaus.groovy.grails.commons.GrailsApplication

@Transactional
class HierProcessService {


    GrailsApplication grailsApplication

    ///  This will be the structure we recursively descend
    class  HierarchyElement {
        int position
        String fullForm
        List<HierarchyElement>  children = []
    }


    /// this convenience structure will hold a map that allows us to shoot directly to the element we want
    ///   Also hold the grand root of the whole tree
    class RootedTree {
        LinkedHashMap<String,HierarchyElement> shortcut =  [:]
        HierarchyElement root = null
    }

    // rread the file in off task
    String readHierarchyFile() {

        String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/elements_ccls_json.txt").file.toString()
        println "Actively loading users from file = ${fileLocation}"
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


    RootedTree addToTheTree(RootedTree treeHolder, String rawForm, List allPositions){
        for (String position in allPositions)  {
            if

        }
        return treeHolder
    }


    // pparse the JSON and then walk through every element, adding elements to the tree as we go
    Object parseJson() {
        LinkedHashMap map = [:]
        String fileContents = readHierarchyFile()
        JsonSlurper slurper = new JsonSlurper()
        def parsedObjects = slurper.parseText(fileContents)
        RootedTree rootedTree = new RootedTree  ()
        for  (element in parsedObjects)  {
            String objectPosition =    element.hierarchy
            String  [] individualLevels = objectPosition.split (".")
            int  hierarchyDepth =   individualLevels.length
            if (hierarchyDepth  > maximumDepth) {maximumDepth  = hierarchyDepth}
            if (map.containsKey(objectPosition))   {
                println "EMERGENCY:  the hierarchy position = ${objectPosition} is duplicated.   Data cannot be successfully processed"
                break;
            }
            map  [objectPosition] =  new  HierarchyElement (depthOfPosition:hierarchyDepth,rawForm:objectPosition)
        }

        return result
    }


}
