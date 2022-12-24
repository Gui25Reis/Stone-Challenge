/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class Foundation.DispatchGroup

import class UIKit.UIAction
import class UIKit.UIAlertAction
import class UIKit.UIBarButtonItem
import class UIKit.UIMenu
import class UIKit.UIAlertController
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
    
    /// Boleano que indica se está filtrando
    private var isFiltering = false
    
    
    
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
    
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação do botão de atualizar os dados
    @objc private func reloadDataAction() {
        if isFiltering {
            let warning = self.createPopUp(
                title: "Pera lá",
                description: "Ainda existe filtro! Remova eles antes de fazer uma nova busca"
            )
            self.navigationController?.present(warning, animated: true)
            
        } else {
            self.comunicateWithApi(isAgain: true)
        }
    }
    
    
    
    /* MARK: - Protocolos */
    
    /* Home Delegate */
    
    internal func openCharacterPage(at index: Int) {
        let data = self.collectionHandler.mainData[index]
        
        let vc = InfosController(character: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /* Search Protocol */
    
    func filterData(by textSearch: String?) {
        self.isFiltering = true
        let allData = APIManager.shared.getDataCached()
        
        var dataFiltered: [ManagedCharacter] = []
        
        // Loop Unrolling
        if let textSearch {
            self.isFiltering = false
            
            if textSearch == "" {
                return self.setupCollectionData(with: allData)
            }
            
            for data in allData {
                if data.name.lowercased().contains(textSearch) {
                    dataFiltered.append(data)
                    continue
                }
                
                if self.checkFilters(for: data) { dataFiltered.append(data) }
            }
            
        } else {
            if APIManager.statusFilter != nil || APIManager.genderFilter != nil {
                for data in allData {
                    if self.checkFilters(for: data) {
                        dataFiltered.append(data)
                    }
                }
            } else {
                self.isFiltering = false
                return self.setupCollectionData(with: allData)
            }
        }
        
        
        self.setupCollectionData(with: dataFiltered)
    }
        
    
    private func checkFilters(for data: ManagedCharacter) -> Bool {
        var statusCheck: Bool? = nil
        if let status = APIManager.statusFilter {
            statusCheck = data.status.name == status
        }
        
        var genderCheck: Bool? = nil
        if let gender = APIManager.genderFilter {
            genderCheck = data.gender.name == gender
        } else {
            return statusCheck ?? false
        }
        
        if let statusCheck, let genderCheck {
            return statusCheck && genderCheck
        } else {
            return genderCheck ?? false
        }
    }
    
    
    /* Controller Actions */
    
    func setupButtonsAction() {
        let statusMenu = self.createMenu(for: StatusTag.self)
        self.myView.setStatusFilterMenu(with: statusMenu)
        
        let genderMenu = self.createMenu(for: GenderTag.self)
        self.myView.setGenderFilterMenu(with: genderMenu)
        
        self.myView.setReloadAction(target: self, action: #selector(self.reloadDataAction))
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
    
    private func comunicateWithApi(isAgain: Bool = false) {
        let group = DispatchGroup()
        group.enter()
        
        APIManager.shared.getApiData() { result in
            defer {group.leave()}
            
            switch result {
            case .failure(let error):
                self.dealWithError(error: error)
                
            case .success(let data):
                group.notify(queue: .main) {
                    self.setupCollectionData(with: data)
                    
                    if isAgain {
                        let warning = self.createPopUp(
                            title: "Novos dadoooos",
                            description: "O que voce pediu já está disponível"
                        )
                        self.navigationController?.present(warning, animated: true)
                    }
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
        
        self.filterData(by: nil)
    }
    
    
    private func dealWithError(error: APIError) {
        print(error.devWarning)
        
        if error != .noResult {
            let warning = self.createPopUp(title: "Calma lá campeão", description: error.userWarning)
            self.navigationController?.present(warning, animated: true)
        }
    }
    
    
    /* MARK: - Errors */
    
    /// Cria um popup de aviso com o erro que aconteceu
    /// - Parameter error: erro
    /// - Returns: pop up com a mensagem do erro
    ///
    /// O pop up não é apresentado, apenas criado.
    private func createPopUp(title: String, description: String) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        return alert
    }
}
