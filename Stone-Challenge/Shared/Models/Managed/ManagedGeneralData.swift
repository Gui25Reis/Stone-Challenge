/* Macro - Grupo 05 */


struct ManagedGeneralData {
    var count: Int
    var pages: Int
    var pagesToSearch: [Int]?
    var lastPage: Int
    
    var pageQuery: String { return "&page=\(self.lastPage)" }
    
    var hasPageToSearch: Bool {
        if let pagesToSearch {
            return !pagesToSearch.isEmpty
        }
        return false
    }
    
    var hasData: Bool { return self.pages != 0 }
    
    
    
    
    init(count: Int, pages: Int, pagesToSearch: [Int]? = nil, lastPage: Int) {
        self.count = count
        self.pages = pages
        self.pagesToSearch = pagesToSearch
        self.lastPage = lastPage
    }
    
    
    init() {
        self.count = 0
        self.pages = 0
        self.pagesToSearch = nil
        self.lastPage = -1
    }
}
