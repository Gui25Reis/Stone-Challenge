/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import Foundation


/**
    Classe responsável pela comunicação direta com a API do Google Books
 
    Aqui é feita as requisições para API do Google books. Sempre que é feito uma nova chamada de uma categoria
 vai ser retornado uma nova lista de livros. Só vai repetir a lista de livros quando acabar os diferentes, ai a lista passa
 a repetir.
*/
class APIManager {
    
    /* MARK: - Atributos */
    
    static let shared = APIManager()
    
    
    static var nameFilter: String? {
        didSet { Self.filterCount += 1 }
    }
    
    static var genderFilter: String? {
        didSet { Self.filterCount += 1 }
    }
    
    static var statusFilter: String? {
        didSet { Self.filterCount += 1 }
    }
    
    
    /* Filtros */
    
    private var isFiltering = false
    
    static var filterCount = 0
    
    private var lastFilter = 0
    
    
    /* Cache */
    
    private var filterRequests: ManagedGeneralData?
    
    private var characterRequests = ManagedGeneralData()
    
    private var characterCache: [Int: [ManagedCharacter]] = [:]
    
    
    
    /* MARK: - Construtor */
    
    private init() {}
    
    
    
    /* MARK: - Encapsulamento */
    
    public func saveOnCache(data: [ManagedCharacter]) {
        let lastPage = self.characterRequests.lastPage
        guard self.characterCache[lastPage] == nil else { return }
        
        self.characterCache[lastPage] = data
    }
    
    
    public func getApiData(_ completionHandler: @escaping (Result<[ManagedCharacter], APIError>) -> Void) {
        let urlRequest = self.getUrl()
        
        self.newQuery(with: urlRequest.url) { result in
            switch result {
            case .failure(let error):
                return completionHandler(.failure(error))
                
            case .success(let data):
                // Erro na hora de decodificar
                guard let result = try? JSONDecoder().decode(APIData.self, from: data) else {
                    return completionHandler(.failure(.badDecode))
                }
                
                // API retornou um erro
                guard result.error == nil else {
                    return completionHandler(.failure(.noResult))
                }
                
                let characterInfo = self.createData(with: result, toCache: urlRequest)
                
                if characterInfo.isEmpty {
                    return completionHandler(.failure(.noResult))
                }
                
                completionHandler(.success(characterInfo))
            }
        }
    }
    
    
    
    public func newQuery(with urlPath: String, _ completionHandler: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = URL(string: urlPath) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Erro da sessão
            if let error = error {
                return completionHandler(.failure(.url(error as? URLError)))
            }
            
            // Não fez conexão com a API: servidor ou internet off
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                return completionHandler(.failure(.badResponse(statusCode: response.statusCode)))
            }
            
            // Erro na hora de pagar os dados
            guard let data = data else {
                return completionHandler(.failure(.badData))
            }
            
            completionHandler(.success(data))
        }
        task.resume()
    }
    
    
    
    /* MARK: - Configurações */
    
    private func getUrl() -> APIUrl {
        var filterQuery = ""
        
        if let name = Self.nameFilter {
            filterQuery += "name=\(name)"
        }
        
        if let status = Self.statusFilter {
            if !filterQuery.isEmpty { filterQuery += "&" }
            filterQuery += "status=\(status)"
        }
        
        if let gender = Self.genderFilter {
            if !filterQuery.isEmpty { filterQuery += "&" }
            filterQuery += "gender=\(gender)"
        }
        
        
        if filterQuery.isEmpty {
            self.isFiltering = false
            self.filterRequests = nil
            return APIUrl(queryType: .allCaracters)
        }
        
        self.isFiltering = true
        return APIUrl(queryType: .filtered, filter: filterQuery)
    }
    
    
    
    private func createData(with apiData: APIData, toCache: APIUrl) -> [ManagedCharacter] {
        guard let result = apiData.results else { return [] }
        self.saveRequest(with: apiData)
        
        let characters = result.map { ManagedCharacter(apiResult: $0) }
        
        self.saveOnCache(data: characters)
        
        return characters
    }
    
    
    
    private func saveRequest(with apiData: APIData) {
        guard let infos = apiData.info else { return }
        
        if !self.characterRequests.hasData {
            let pagesNumbers = Array(2...infos.pages).shuffled()
            self.characterRequests.pagesToSearch = pagesNumbers
            
            self.characterRequests.pages = infos.pages
            self.characterRequests.count = infos.count
        }
        
        if isFiltering {
//            if var filterRequests {
//                let pagesNumbers = Array(2...infos.pages).shuffled()
//                filterRequests.pagesToSearch = pagesNumbers
//
//                filterRequests.pages = infos.pages
//                filterRequests.count = infos.count
//                return
//            }
//
//            guard self.lastFilter != Self.filterCount else { return }
//
//
//            let pagesNumbers = Array(2...infos.pages).shuffled()
//            self.filterRequests.pagesToSearch = pagesNumbers
//
//            self.filterRequests.pages = infos.pages
//            self.filterRequests.count = infos.count
        }
    }
    
    
    private func getNewPage() -> Int? {
        var requests: ManagedGeneralData? = self.characterRequests
        if isFiltering {
            requests = self.filterRequests
        }
        
        guard var requests else { return nil }
        
        if let newPage = requests.pagesToSearch?.first {
            requests.pagesToSearch?.remove(at: 0)
            return newPage
        }
        // Foram todas as páginas
        return -1
    }
}


struct APIUrl {
    let url: String
    let queryType: APIQueries
    
    init(queryType: APIQueries) {
        self.queryType = queryType
        self.url = queryType.query
    }
    
    init(queryType: APIQueries, filter: String) {
        self.queryType = queryType
        self.url = "\(queryType.query)\(filter)"
    }
}
