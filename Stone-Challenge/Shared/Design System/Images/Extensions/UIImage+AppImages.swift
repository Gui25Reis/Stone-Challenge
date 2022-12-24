/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UIImage


extension UIImage {
    
    /// Cria uma imagem a partir de um asset do projeto (`AppImages`)
    /// - Parameter asset: asset
    convenience init?(asset: AppImages) {
        self.init(named: asset.fileName)
    }
}
