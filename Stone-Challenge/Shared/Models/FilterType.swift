/* Gui Reis    -    gui.sreis25@gmail.com */

/// Possíveis filtros que podem ser feito
enum FilterType {
    
    /* MARK: - Casos */
    
    case gender
    case status
    
    
    
    /* MARK: - Casos */
    
    /// Nome do filtro
    var title: String {
        switch self {
        case .gender: return "Gender"
        case .status: return "Status"
        }
    }
    
    /// Nome do parâmetro
    var queryParameter: String {
        switch self {
        case .gender: return "gender"
        case .status: return "status"
        }
    }
}
