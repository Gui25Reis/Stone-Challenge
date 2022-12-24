/* Gui Reis    -    gui.sreis25@gmail.com */


/// Tags usadas para o estado de vida dos personagens
enum StatusTag: TagInfo {
    
    /* MARK: - Casos */
    
    case alive
    case dead
    case unknown
    case none
    
    
    
    /* MARK: - Atributos */
    
    var filter: FilterType { return FilterType.status }
    
    var name: String {
        switch self {
        case .alive: return "Alive"
        case .dead: return "Dead"
        case .unknown: return "Unknown"
        case .none: return "none"
        }
    }
    
    var color: AppColors {
        switch self {
        case .alive: return .statusAlive
        case .dead: return .statusDead
        case .unknown: return .statusUnknown
        case .none: return .noneTag
        }
    }
    
    
    
    /* MARK: - Métodos */
    
    /// Faz a conversão da palavra (string) para o tipo do enum (case)
    /// - Parameter status: gênero em string
    /// - Returns: tipo do genêro
    static func getType(by name: String) -> StatusTag {
        switch name.lowercased() {
        case "alive": return .alive
        case "dead": return .dead
        default: return .unknown
        }
    }
}
