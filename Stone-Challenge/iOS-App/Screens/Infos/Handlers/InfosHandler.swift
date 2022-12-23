/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Data source das tables da página de ajustes
class InfosHandler: NSObject, TableHandler {

    /* MARK: - Atributos */
    
    /* Dados */
    
    /// Dados usados no data source referente as informações das informações gerais
    private lazy var infoData: [TableCellData] = []
    
    /// Dados usados no data source referente as informações de compartilhamento
    private lazy var placeData: [TableCellData] = []
    
    /// Dados usados no data source referente aos tipos de pontos
    private lazy var otherData: [TableCellData] = []
    
    
    
    /* MARK: - Protocolo */

    func getDataCount(for dataType: Int) -> Int {
        switch dataType {
        case 0: return self.infoData.count
        case 1: return self.placeData.count
        case 2: return self.otherData.count
        default: return 0
        }
    }
    
    
    func registerCell(in tables: [CustomTable]) {
        tables.forEach() { $0.registerCell(for: InfosCell.self) }
    }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Dados usados dos ajustes
    public var mainData: ManagedCharacter? {
        didSet {
            self.setupDatas()
        }
    }
    
    
    
    /* MARK: - Data Source */
    
    /// Mostra quantas células vão ser mostradas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getDataCount(for: tableView.tag)
    }
    
    
    /// Configura uma célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfosCell.identifier, for: indexPath) as? InfosCell else {
            return UITableViewCell()
        }
        
        switch tableView.tag {
        
        case 0: // infos gerais
            let data = self.infoData[indexPath.row]
            cell.setupCellData(with: data)
    
        case 1: // local
            let data = self.placeData[indexPath.row]
            cell.setupCellData(with: data)
            
        case 2: // episodios
            let data = self.otherData[indexPath.row]
            cell.setupCellData(with: data)
        
        default: break
        }
        return cell
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura os dados da tabela
    private func setupDatas() {
        if let infos = self.mainData {
            self.infoData = [
                TableCellData(primaryText: "Name", secondaryText: infos.name),
                TableCellData(primaryText: "Gender", secondaryText: infos.gender.name),
                TableCellData(primaryText: "Specie", secondaryText: infos.species),
                TableCellData(primaryText: "Type", secondaryText: infos.type),
                TableCellData(primaryText: "Status", secondaryText: infos.status.name),
            ]
            
            
            self.placeData = [
                TableCellData(primaryText: "Origin", secondaryText: infos.origin.name),
                TableCellData(primaryText: "Last location", secondaryText: infos.location.name),
            ]
            
            
            self.otherData = [
                TableCellData(primaryText: "Episodes", secondaryText: "\(infos.episodes.count)"),
            ]
        }
    }
}
