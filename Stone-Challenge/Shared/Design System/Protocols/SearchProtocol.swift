/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class Foundation.NSObject


/// Os tipos que estão de acordo com esse protocolo possuem uma search bar
protocol SearchProtocol: NSObject {
    
    /// Faz um filtro a partir do dado passadp
    /// - Parameter textSearch: texto da search
    func filterData(by textSearch: String)
}
