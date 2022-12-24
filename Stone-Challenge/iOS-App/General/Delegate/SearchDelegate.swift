/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class Foundation.NSObject
import class UIKit.UISearchBar

import protocol UIKit.UISearchBarDelegate


/// Delegate da search bar
class SearchDelegate: NSObject, UISearchBarDelegate {
    
    /* MARK: - Atributos */
    
    /// Comunicação entre o delegate com o tipo que está de acordo com o protocolo da search
    private weak var searchProtocol: SearchProtocol?
        

    
    /* MARK: - Encapsulamento */
    
    /// Define qual vai ser o protocolo
    /// - Parameter protocol: protocolo de comunicação
    public func setProtocol(with searchProtocol: SearchProtocol ) {
        self.searchProtocol = searchProtocol
    }
    
    
    
    /* MARK: - Delegate */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchProtocol?.filterData(by: searchText.lowercased())
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text?.lowercased() ?? ""
        self.searchProtocol?.filterData(by: text)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchProtocol?.filterData(by: nil)
    }
}
