/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UIAction
import class UIKit.UIBarButtonItem
import class UIKit.UIMenu
import class UIKit.UIViewController

import class Foundation.DispatchGroup



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
        self.comunicateWithApi()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.myView.reloadCollectionData()
    }
    
    
    
    /* MARK: - Protocolos */
    
    /* Home Delegate */
    
    internal func openCharacterPage(at index: Int) {
        let data = self.collectionHandler.mainData[index]
        
        let vc = InfosController(character: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /* Search Protocol */
    
    func filterData(by textSearch: String) {
        
    }
    
    
    /* Controller Actions */
    
    func setupButtonsAction() {
        let statusMenu = self.createMenu(for: StatusTag.self)
        self.myView.setStatusFilterMenu(with: statusMenu)
        
        let genderMenu = self.createMenu(for: GenderTag.self)
        self.myView.setGenderFilterMenu(with: genderMenu)
    }
    
    
    func setupDelegates() {
        self.searchHandler.setProtocol(with: self)
        self.collectionHandler.setHomeDelegate(with: self)
        
        self.collectionHandler.link(with: self.myView.mainCollection.collection)
    }
    
    
    func setupNavigation() {
        self.title = "Characters"
        
        self.navigationItem.searchController = self.searchHandler
    }
    
    
    
    /* MARK: - Configurações */
    
    private func comunicateWithApi() {
        let group = DispatchGroup()
        group.enter()
        
        APIManager.shared.getApiData() { result in
            defer {group.leave()}
            
            switch result {
            case .failure(let error):
                print(error.devWarning)
                
            case .success(let data):
                group.notify(queue: .main) {
                    self.setupCollectionData(with: data)
                }
            }
        }
    }
    
    
    private func setupCollectionData(with data: [ManagedCharacter]) {
        self.myView.reloadCollectionData()
        self.collectionHandler.mainData = data
        self.myView.reloadCollectionData()
    }
    
    
    
    
    /// Cria o context menu para a célula de mostrar os estados disponiveis
    /// - Parameter cell: célula que vai ser atribuida o menu
    private func createMenu<T: TagInfo>(for enumType: T.Type) -> UIMenu {
        var title = ""
        var actions: [UIAction] = []
        
        for item in enumType.allCases {
            let action = UIAction(
                title: item.name,
                image: Tag.getImage(for: item)
            ) {_ in
                self.filterAction(with: item)
            }
            
            actions.append(action)
            title = item.filter.title
        }
        
        return UIMenu(title: title, children: actions)
    }
    
    
    
    private func filterAction(with item: any TagInfo) {
        self.myView.updateMenuTagSelected(to: item)
        
        switch item.filter {
        case .gender:
            if item.name == "none" {
                APIManager.genderFilter = nil
            } else {
                APIManager.genderFilter = item.name
            }

        case .status:
            if item.name == "none" {
                APIManager.statusFilter = nil
            } else {
                APIManager.statusFilter = item.name
            }
        
        default: break
        }
    }
}
