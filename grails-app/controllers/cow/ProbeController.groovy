package cow

class ProbeController {
    HierProcessService hierProcessService
    def probe_targets() {}
    def HierCat() {
        //hierProcessService.readHierarchyFile()
        hierProcessService.parseJson()
        render(view: 'HierCat')}
}
