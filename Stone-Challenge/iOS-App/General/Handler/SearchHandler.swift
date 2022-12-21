/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */

import class Foundation.NSCoder
import class Foundation.NSObject
import class UIKit.UISearchBar
import class UIKit.UISearchController

import protocol UIKit.UISearchBarDelegate



class SearchHandler: UISearchController, UISearchBarDelegate {
    
    /* MARK: - Atributos */
    
    /// Comunicação entre o delegate com o tipo que está de acordo com o protocolo da search
    private weak var searchProtocol: SearchProtocol?
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(searchResultsController: nil)
        
        self.setupHandler()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define qual vai ser o protocolo
    /// - Parameter protocol: protocolo de comunicação
    public func setProtocol(with searchProtocol: SearchProtocol ) {
        self.searchProtocol = searchProtocol
    }
    
    
    
    /* MARK: - Delegate */
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.searchProtocol?.filterData(by: searchText.lowercased())
//    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text?.lowercased() ?? ""
        self.searchProtocol?.filterData(by: text)
    }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configurações inicias da classe
    private func setupHandler() {
        self.searchBar.delegate = self
    }
}
