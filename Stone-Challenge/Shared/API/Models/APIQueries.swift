/* Macro - Grupo 05 */


/// URLs da api para fazer as requisições
enum APIQueries {
    case allCaracters
    case filtered
    
    var query: String {
        switch self {
        case .allCaracters: return "https://rickandmortyapi.com/api/character"
        case .filtered: return "https://rickandmortyapi.com/api/character/?"
        }
    }
}
