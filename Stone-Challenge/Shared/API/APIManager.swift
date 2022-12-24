/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import Foundation


/// Classe responsável pela comunicação externa com algum link
///
/// Nessa classe é feita a comunicação com a API principal do app e os resultados principais
/// (não considerando os filtros) são salvo em memória.
class APIManager {
    
    /* MARK: - Atributos */
    
    static let shared = APIManager()
    
    /// Valor do filtro pelo nome
    static var nameFilter: String? {
        didSet { Self.filterCount += 1 }
    }
    
    /// Valor do filtro pelo gênero
    static var genderFilter: String? {
        didSet { Self.filterCount += 1 }
    }
    
    /// Valor do filtro pelo estado (vivo ou morto)
    static var statusFilter: String? {
        didSet { Self.filterCount += 1 }
    }
    
    /// URL principal da api
    private let mainUrl = "https://rickandmortyapi.com/api/character/"
    
    
    /* Filtros */
    
    /// Boleano que indica se possui algum valor para filtragem
    private var isFiltering = false
    
    /// Contador de diferentes de tipos de filtragem feitas
    static var filterCount = 0
    
    /// "Index" do último filtro realizado
    private var lastFilter = 0
    
    
    /* Cache */
    
    /// Informações sobre o resultado do filtro
    private var filterRequests: ManagedGeneralData?
    
    /// Informações sobre o resultado da chamada principal
    private var characterRequests = ManagedGeneralData()
    
    /// Valores que já foram buscados
    ///
    /// A chave é a página de busca e o valor são os resultados
    private var characterCache: [Int: [ManagedCharacter]] = [:]
    
    
    
    /* MARK: - Construtor */
    
    private init() {}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Faz a comunicação direto com a API
    /// - Parameter completionHandler: dois possíveis resultados: dados ou erro
    ///
    /// Quando faz a requisição, em caso de sucesso é retornado todos os dados buscados até o momento,
    /// ou seja, os que já foram + os novos. Quando tem filtro é o mesmo retorno
    public func getApiData(_ completionHandler: @escaping (Result<[ManagedCharacter], APIError>) -> Void) {
        let urlRequest = self.getUrl()
        
        if urlRequest.isEmpty {
            return completionHandler(.failure(.noPageAvaiable))
        }
        
        self.newQuery(with: urlRequest) { result in
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
                
                let characterInfo = self.createData(with: result)
                
                if characterInfo.isEmpty {
                    return completionHandler(.failure(.noResult))
                }
                
                completionHandler(.success(characterInfo))
            }
        }
    }
    
    
    
    /// Faz a comunicação com qualquer URL
    /// - Parameters:
    ///   - urlPath: url para comunicação
    ///   - completionHandler: dois possíveis resultados: dados ou erro
    public func newQuery(with urlPath: String, _ completionHandler: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = URL(string: urlPath) else {
            return completionHandler(.failure(.badURL))
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
    
    
    /// Pega todos os dados que estào no cache
    /// - Returns: dados do cache
    public func getDataCached() -> [ManagedCharacter] {
        var data: [ManagedCharacter] = []
        self.characterCache.forEach() { data += $0.value }
        
        return data
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Cache */
    
    /// Salva os valores encontrado no cache
    /// - Parameter data: valore encontrados
    ///
    /// Usado apenas para os personagens da URL principal
    private func saveOnCache(data: [ManagedCharacter]) {
        let lastPage = self.characterRequests.lastPage
        guard self.characterCache[lastPage] == nil else { return }
        
        self.characterCache[lastPage] = data
    }
    
    
    /* API */
    
    /// Pega a URL para comunicação com a API princiapl
    /// - Returns: url para comunicação
    private func getUrl() -> String {
        let filterQuery = self.getFilterParameter()
        
        var url = ""
        if filterQuery.isEmpty {
            self.isFiltering = false
            self.filterRequests = nil
            url = self.mainUrl
        } else {
            self.isFiltering = true
            url = "\(self.mainUrl)?\(filterQuery)"
        }
        
        
        if let page = self.getNewPage() {
            if page == -1 { return "" }
            
            if isFiltering {
                self.filterRequests?.lastPage = page
                url += self.filterRequests?.pageQuery ?? ""
            } else {
                self.characterRequests.lastPage = page
                url += "?\(self.characterRequests.pageQuery)"
            }
        }
        
        return url
    }
    
    
    
    /// Verifica se existe algum valor para filtro
    /// - Returns: parte da url com os parâmetros
    private func getFilterParameter() -> String {
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
        
        return filterQuery
    }
    
    
    /// Cria os dados para reposta
    /// - Parameter apiData: dados que vieram da api
    /// - Returns: dados usados no app
    private func createData(with apiData: APIData) -> [ManagedCharacter] {
        guard let result = apiData.results else { return [] }
        
        self.saveRequest(with: apiData)
        
        let characters = result.map { ManagedCharacter(apiResult: $0) }
        self.saveOnCache(data: characters)
        
        return self.getDataCached()
    }
    
    
    /// Salva os valores da requisiçào
    /// - Parameter apiData: resultados da requisição
    ///
    /// Essa função é reponsável por criar os dados iniciais após a primiera requisição do ciclo de vida do app
    private func saveRequest(with apiData: APIData) {
        guard let infos = apiData.info else { return }
        
        if !self.characterRequests.hasData {
            let pagesNumbers = Array(2...infos.pages).shuffled()
            self.characterRequests.pagesToSearch = pagesNumbers
            
            self.characterRequests.pages = infos.pages
            self.characterRequests.count = infos.count
        }
        
        // TODO: Filtro direto pela API
        // if isFiltering { }
    }
    
    
    /// Pega uma nova página como resultado
    /// - Returns: nova página
    ///
    /// Caso o retorno seja -1 quer dizer que nào possui mais páginas para fazer uma
    /// nova requisição. Se o valor não existir é porque nem existe páginas para poder
    /// navegar
    private func getNewPage() -> Int?  {
        if var pagesAvaiable = self.characterRequests.pagesToSearch {
            if let newPage = pagesAvaiable.first {
                pagesAvaiable.removeFirst()
                
                self.characterRequests.pagesToSearch = pagesAvaiable
                return newPage
            }
            return -1
        }
        return nil
    }
}
