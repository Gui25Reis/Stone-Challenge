/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class Foundation.NSCoder

import class UIKit.UIViewController
import class UIKit.UIView



/// Controller da tela de informações de um personagem
class InfosController: UIViewController, ControllerActions {
    
    /* MARK: - Atributos */
    
    /// View principal que a controller vai usar
    private let myView: InfosView
    
    
    /// Handler da table de informa;còes do personagens
    private let tableHandler = InfosHandler()
    
    
    
    /* MARK: - Construtor */
    
    init(character: ManagedCharacter) {
        self.myView = InfosView(infos: character)
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupTableData(with: character)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
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
    
    
    func setupDelegates() {
        self.tableHandler.link(with: self.myView.mainTable)
    }
    
    
    func setupNavigation() {
        self.title = "Infos"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupTableData(with data: ManagedCharacter) {
        self.tableHandler.mainData = data
        self.myView.reloadTableData()
    }
}
