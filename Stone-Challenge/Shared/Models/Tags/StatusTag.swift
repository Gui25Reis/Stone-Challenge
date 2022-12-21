/* Gui Reis    -    gui.sreis25@gmail.com */


/// Tags usadas para o estado de vida dos personagens
enum StatusTag: TagInfo {
    
    /* MARK: - Casos */
    
    case alive
    case dead
    case unknown
    
    
    
    /* MARK: - Atributos */
    
    var name: String {
        switch self {
        case .alive: return "Male"
        case .dead: return "Female"
        case .unknown: return "Unknown"
        }
    }
    
    
    var color: AppColors {
        switch self {
        case .alive: return .statusAlive
        case .dead: return .statusDead
        case .unknown: return .statusUnknown
        }
    }
    
    
    
    /* MARK: - Métodos */
    
    /// Faz a conversão da palavra (string) para o tipo do enum (case)
    /// - Parameter status: gênero em string
    /// - Returns: tipo do genêro
    static func getType(by status: String) -> StatusTag {
        switch status.lowercased() {
        case "alive": return .alive
        case "dead": return .dead
        default: return .unknown
        }
    }
}
