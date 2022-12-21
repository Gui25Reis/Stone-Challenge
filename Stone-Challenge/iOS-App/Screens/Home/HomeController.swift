/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UIBarButtonItem
import class UIKit.UIViewController



/// Controller da tela principal
class HomeController: UIViewController, ControllerActions, HomeDelegate {
    
    /* MARK: - Atributos */
    
    /// View principal que a controller vai usar
    private let myView = HomeView()
    
    
    /// Handler da collection dos personagens
    private let collectionHandler = CharactersHandler()
    
    
    
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
    
    
    /* Controller Action */
    
    func setupButtonsAction() {}
    
    
    func setupDelegates() {
        self.collectionHandler.setHomeDelegate(with: self)
        
        self.collectionHandler.link(with: self.myView.mainCollection.collection)
    }
    
    
    func setupNavigation() {
        self.title = "Caracters"
        
        let searchBar = self.myView.searchNavigation
        self.navigationItem.titleView = searchBar
    }
}
