package cow

import grails.transaction.Transactional
import org.codehaus.groovy.grails.commons.GrailsApplication

@Transactional
class HierProcessService {


    GrailsApplication grailsApplication

    LinkedHashMap readHierarchyFile() {
        LinkedHashMap map = [:]
        String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/elements_ccls_json.txt").file.toString()
        println "Actively loading users from file = ${fileLocation}"
        File file = new File(fileLocation)
        int counter = 1
        boolean headerLine = true
        file.eachLine {
            if (headerLine) {
                headerLine = false
            } else {
                // List<String> fields = it.split('\t')
                println(it)
            }
        }
        return map
    }


}
