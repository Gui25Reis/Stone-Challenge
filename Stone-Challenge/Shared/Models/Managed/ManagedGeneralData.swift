/* Gui Reis    -    gui.sreis25@gmail.com */


/// Modelo de dados usado para informações de um resultado de uma requisição
struct ManagedGeneralData {
    
    /* MARK: - Atributos */
    
    /// Quantidade de valores disponíveis
    var count: Int
    
    /// Quantidade de páginas
    var pages: Int
    
    /// Número das páginas (em ordem randomica)
    var pagesToSearch: [Int]?
    
    ///Última página que foi navegada
    var lastPage: Int
    
    
    /* Variáveis computáveis */
    
    /// Parâmetro da url para a última página navegada
    var pageQuery: String { return "page=\(self.lastPage)" }
    
    /// Boleano que indica se ainda tem página para pegar novos dados
    var hasPageToSearch: Bool {
        if let pagesToSearch {
            return !pagesToSearch.isEmpty
        }
        return false
    }
    
    /// Boleano que indica se tem algum dado na struct
    var hasData: Bool { return self.pages != 0 }
    
    
    
    /* MARK: - Construtores */
    
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
