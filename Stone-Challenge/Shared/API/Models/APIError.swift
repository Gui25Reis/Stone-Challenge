/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import struct Foundation.URLError


/// Possíveis erros que podem acontecer durante a comunicação com a  API
enum APIError: ErrorWarnings {
    
    /* MARK: - Casos */
    
    case badURL
    case badData
    case badDecode
    case badResponse(statusCode:Int)
    case url(URLError?)
    case noResult
    
    
    
    /* MARK: - Atributos */
    
    /// Feedback para o usuário
    var userWarning: String {
        switch self {
        case .badURL, .badDecode, .badData:
            return "Desculpe mas algo deu errado :/"

        case .badResponse(_):
            return "Desculpe mas estamos com problemas na hora de se counicar com o servidor."

        case .url(let error):
            return error?.localizedDescription ?? "Erro com a URL passada"
        
        case .noResult:
            return "Não foi achado um resultado."
        }
    }

    
    /// Feedback completo para desenvolver
    var devWarning: String {
        switch self {
        case .badURL: return "URL inválida"
        case .badData: return "Erro nos dados recebidos"
        case .badDecode: return "Erro na hora de decodificar"
        case .noResult: return "Não foi encontrado um endereço. Há um erro no endereço passado."

        case .url(let error):
            return error?.localizedDescription ?? "Eror na sessão com URL"

        case .badResponse(statusCode: let statusCode):
            return "Erro na chamada, status: \(statusCode)"
        }
    }
}
