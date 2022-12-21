/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UIColor


/// Casos de uso das cores usadas no projeto
enum AppColors {
    
    /* MARK: - Casos */
    
    /* Status */
    
    case statusUnknown
    
    case statusAlive
    
    case statusDead
    
    
    /* Gender */
    
    case genderMale
    
    case genderFemale
    
    case genderGenderless
    
    case genderUnknown

    
    /* Componentes */
    
    /// Safe areas
    case safeAreaColor
    
    /// Fundo das tabelas
    case tableBackColor
    
    /// Fundo das tabelas
    case collectionBackColor
    
    /// Cor do botão
    case button
    
    
    /* Geral */
    
    /// Fundo das views
    case viewBack
    
    
    /* Textos */
    
    /// Texto mais usados
    case primaryText
    
    /// Textos não tão usados
    case secondaryText
    
    
    /* MARK: - Nome das cores */
    
    /// Nome do asset da cor
    var colorAsset: ColorAsset? {
        switch self {
        case .statusAlive: return .green
        case .statusDead: return  .red
            
        case .statusUnknown, .genderUnknown:
            return .gray
            
        case .genderMale: return .blue
        case .genderFemale: return .pink
        case .genderGenderless: return .yellow
            
        case .safeAreaColor: return .safeAreaColor
        case .tableBackColor, .collectionBackColor:
            return .safeAreaColor
            
        default: return nil
        }
    }
    
    
    /// Nome da cor usada do sistema
    var systemColor: UIColor? {
        switch self {
        case .button: return .systemBlue
        case .viewBack: return .systemGray6
        
        case .primaryText: return .label
        case .secondaryText: return .white
            
        default: return nil
        }
    }
}
