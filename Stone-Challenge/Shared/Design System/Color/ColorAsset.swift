/* Gui Reis    -    gui.sreis25@gmail.com */


/// Assets de cores adicionado ao projeto
enum ColorAsset {
    
    /* MARK: - Casos */
    
    case blue
    case green
    case pink
    case red
    case yellow
    case gray
    
    case tableColor
    case safeAreaColor
    
    
    /* MARK: - Atributos */
    
    /// Nome do asset
    var name: String {
        switch self {
        case .blue: return "blue_92CBCE"
        case .green: return "green_A9CE92"
        case .pink: return "green_A9CE92"
        case .red: return "red_CE9292"
        case .yellow: return "yellow_CEC192"
        case .gray: return "gray_C4CAD3"
        
        case .tableColor: return "tableColor"
        case .safeAreaColor: return "safeAreaColor"
        }
    }
}
