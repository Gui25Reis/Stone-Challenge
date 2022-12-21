/* Gui Reis    -    gui.sreis25@gmail.com */


/// Tags usadas para o gênro dos personagens
enum GenderTag: TagInfo {
    
    /* MARK: - Casos */
    
    case male
    case female
    case genderless
    case unknown
    
    
    
    /* MARK: - Atributos */
    
    var name: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        case .genderless: return "Genderless"
        case .unknown: return "Unknown"
        }
    }
    
    
    var color: AppColors {
        switch self {
        case .male: return .genderMale
        case .female: return .genderFemale
        case .genderless: return .genderGenderless
        case .unknown: return .genderUnknown
        }
    }
    
    
    
    /* MARK: - Métodos */
    
    /// Faz a conversão da palavra (string) para o tipo do enum (case)
    /// - Parameter gender: gênero em string
    /// - Returns: tipo do genêro
    static func getType(by gender: String) -> GenderTag {
        switch gender.lowercased() {
        case "male": return .male
        case "female": return .female
        case "genderless": return .genderless
        default: return .unknown
        }
    }
}
