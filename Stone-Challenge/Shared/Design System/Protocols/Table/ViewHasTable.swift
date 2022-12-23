/* Gui Reis    -    gui.sreis25@gmail.com */


/// Os tipos que estão de acordo com esse protocolo possuem uma o mais tabelas
protocol ViewHasTable {
    
    /// Tabelas que estão sendo usadas
    var mainTable: [CustomTable] { get set }
}


extension ViewHasTable {
    
    /// Define o delegate e data source da collection
    internal func reloadTableData() {
        self.mainTable.forEach() { $0.reloadTableData() }
    }
}
