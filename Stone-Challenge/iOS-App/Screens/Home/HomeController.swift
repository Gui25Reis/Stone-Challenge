/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UIBarButtonItem
import class UIKit.UIViewController


/// Controller da tela principal
class HomeController: UIViewController, ControllerActions, HomeDelegate, SearchProtocol {
    
    /* MARK: - Atributos */
    
    /// View principal que a controller vai usar
    private let myView = HomeView()
    
    
    /// Handler da collection dos personagens
    private let collectionHandler = CharactersHandler()
    
    /// Handler da search bar da navigation
    private let searchHandler = SearchHandler()
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupController()
    }
    
    
    
    /* MARK: - Protocolos */
    
    /* Home Delegate */
    
    internal func openCharacterPage(at index: Int) {
        
    }
    
    
    /* Search Protocol */
    
    func filterData(by textSearch: String) {
        
    }
    
    
    /* Controller Actions */
    
    func setupButtonsAction() {}
    
    
    func setupDelegates() {
        self.searchHandler.setProtocol(with: self)
        self.collectionHandler.setHomeDelegate(with: self)
        
        self.collectionHandler.link(with: self.myView.mainCollection.collection)
    }
    
    
    func setupNavigation() {
        self.title = "Caracters"
        
        self.navigationItem.searchController = self.searchHandler
    }
}
