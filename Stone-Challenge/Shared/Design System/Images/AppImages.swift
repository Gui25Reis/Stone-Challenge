/* Gui Reis    -    gui.sreis25@gmail.com */


/// Imagens do tipo asset usados no projeto
enum AppImages {
    
    /*  MARK: - Casos */
    
    /// Imagem padrão dos personagens
    case defaultImage
    
    
    
    /*  MARK: - Atributos */
    
    /// Nome do arquivo salvonos assets
    var fileName: String {
        switch self {
        case .defaultImage: return "defaultImage.jpeg"
        }
    }
}
