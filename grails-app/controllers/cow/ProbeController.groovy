package cow

class ProbeController {
    HierProcessService hierProcessService
    def index(){
        render(probe_targets)
    }
    def probe_targets() {}
    def HierCat() {
        //hierProcessService.readHierarchyFile()
        hierProcessService.buildJsonRepresentationOfTree()
        render(view: 'HierCat')}
}
