/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UIViewController
import class UIKit.UIView


/// Controller da tela de informações de um personagem
class InfosController: UIViewController, ControllerActions {
    
    /* MARK: - Atributos */
    
    /// View principal que a controller vai usar
    private let myView = UIView()
    
    
    /// Handler da table de informa;còes do personagens
//    private let tableHandler =
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupController()
    }
    
    
    
    /* MARK: - Protocolos */
    
    
    
    /* Controller Action */
    
    func setupButtonsAction() {}
    
    
    func setupDelegates() {}
    
    
    func setupNavigation() {
        self.title = "Infos"
    }
}
