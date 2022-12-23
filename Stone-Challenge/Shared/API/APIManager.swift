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
    
    static var nameFilter: String?
    
    static var genderFilter: String?
    
    static var statusFilter: String?
    
    
    static let shared = APIManager()
    
    
    
    private init() {}
    
    
    public func getApiData(_ completionHandler: @escaping (Result<[ManagedCharacter], APIError>) -> Void) {
        let urlRequest = self.getUrl()
        
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
    
    
    
    
    /**
        Faz a chamada da API com base na palavra chave.
     
        - Parametros:
            - text: palavra chave para fazer a busca na API
 
        - CompletionHandler:
            - Result: lista dos livors recebidos (lista com no máximo 40 livros)
            - Error: erro caso tenha algum
    */
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
    
    
    private func getUrl() -> String {
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
        
        
        if filterQuery.isEmpty { return APIQueries.allCaracters.query }
        return "\(APIQueries.filtered.query)\(filterQuery)"
    }
    
    
    
    private func createData(with apiData: APIData) -> [ManagedCharacter] {
        guard let result = apiData.results else { return [] }
        return result.map { ManagedCharacter(apiResult: $0) }
    }
}
