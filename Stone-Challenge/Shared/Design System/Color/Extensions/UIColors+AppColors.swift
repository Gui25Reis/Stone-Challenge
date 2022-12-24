/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UIColor


extension UIColor {
    
    /// Cria uma cor de acordo com os casos de uso das cores do projeto
    /// - Parameter appColor: tipo de cor
    convenience init?(_ appColor: AppColors) {
        if let system = appColor.systemColor {
            self.init(cgColor: system.cgColor)
            return
        }
        
        if let assetName = appColor.colorAsset?.name {
            self.init(named: assetName)
            return
        }
        
        self.init()
    }
}
