/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class Foundation.NSObject


/// Os tipos que estão de acordo com esse protocolo possuem uma collection
protocol SearchProtocol: NSObject {
    
    /// Faz um filtro a partir do dado passadp
    /// - Parameter textSearch: texto da search
    func filterData(by textSearch: String)
}
