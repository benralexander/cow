
package cow

import cbbo.ctrp.RunDataGeneration


class GroovyLauncherController {

    def index() {
        render(view: 'cddbApiTester')
    }
    def cddbApiTester() {
        RunDataGeneration runDataGeneration = new RunDataGeneration()
        render(view:'cddbApiTester')
    }
    def generateSunburst() {

        cbbo.Prober prober = new cbbo.Prober()
        TreeSet<Integer> treeSet = prober.readFromFile2()
        prober.display(treeSet)
        TreeSet<String> uniprotIds = prober.readFromBioIDFile()
        TreeSet<String> uniprotSet = prober.convertBiologyIdsToUniprotIds(uniprotIds)
        TreeSet<String> filteredUniprotSet = prober.record (uniprotSet)
        cbbo.NodeHolder nodeHolder =  prober.convertUniprotIdsToNodes(filteredUniprotSet)
        println "total number nodes = ${nodeHolder.nodeFinder.size()}"
        nodeHolder.adjustArcWidthSlices()
        nodeHolder.createDummyNodes()
        nodeHolder.printRecursiveDescent ()

        render(view:'cddbApiTester')
    }

}
