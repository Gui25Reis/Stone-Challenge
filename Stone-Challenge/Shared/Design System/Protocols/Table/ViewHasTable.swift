/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UICollectionViewFlowLayout


/// Os tipos que estão de acordo com esse protocolo possuem uma collection na UI
protocol ViewHasTable {
    
    var mainTable: CustomTable {get set}
    
    /* MARK: - Métodos */
    
    /// Registra as células na collections
    func registerCells()
    

    /// Define o layout da collection
    func setupCollectionFlow()
}



extension ViewHasTable {
    
    /// Faz a configuração inicial da collection
    internal func setupTable() {
        self.registerCells()
    }
    
    
    /// Define o delegate e data source da collection
    internal func setupTableHandler(with handler: TableHandler) {
        self.mainTable.setupHandler(with: handler)
    }
    
    
    /// Define o delegate e data source da collection
    internal func reloadTableData() {
        self.mainTable.reloadTableData()
    }
}
