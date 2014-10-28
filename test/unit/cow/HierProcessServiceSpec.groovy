package cow

import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@Unroll
@TestFor(HierProcessService)
class HierProcessServiceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        given:
        String testFile="""
{"hierarchy":"1.2.40"},
{"hierarchy":"1.3.30"},
{"hierarchy":"1.3.30"},
{"hierarchy":"1.3.30"},
{"hierarchy":"1.3.30"},
{"hierarchy":"1.3.30"},
{"hierarchy":"1.3.30"},
{"hierarchy":"1.3.30"},
{"hierarchy":"1.3.30"},
{"hierarchy":"1.4.28"},
{"hierarchy":"1.4.28"},
{"hierarchy":"1.4.31"},
{"hierarchy":"1.4.41"},
{"hierarchy":"1.4.41"},
{"hierarchy":"1.4.31"},
{"hierarchy":"1.4.28"},
{"hierarchy":"1.4.41"},
{"hierarchy":"1.4.41"},
{"hierarchy":"1.4.28"},
{"hierarchy":"1.4.28"},
{"hierarchy":"1.4.41"},
{"hierarchy":"1.4.41"},
{"hierarchy":"1.4.28"},
{"hierarchy":"1.4.28"},
{"hierarchy":"1.4.31"},
{"hierarchy":"1.4.28"},
{"hierarchy":"1.4.41"},
{"hierarchy":"1.5.30"},
{"hierarchy":"1.5.30.72"},
{"hierarchy":"1.5.30.72"},
{"hierarchy":"1.5.30.72"},
{"hierarchy":"1.5.30"},
{"hierarchy":"1.5.30.72"},
{"hierarchy":"1.5.30"},
{"hierarchy":"1.5.30"},
{"hierarchy":"1.5.30"},
{"hierarchy":"1.5.30.72"},
{"hierarchy":"1.5.30"},
{"hierarchy":"1.5.30.72"}
""".toString()
        when:
        HierProcessService.RootedTree rootedTree = service.convertHierarchyIntoTree(testFile)
        LinkedHashMap<String,String>  map = service.convertNamesIntoMap()
        service.assignNamesToTree(rootedTree.root,  map)
        StringBuilder sb = new StringBuilder()
        String s = service.generateBracketedJson (rootedTree.root)
        then:
        s

    }
}
