/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Delegate geral da table
class GeneralTableDelegate: NSObject, UITableViewDelegate {
    
    
    static let shared = GeneralTableDelegate()
    
    

    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        // guard let protocol = self.nomeProtocol else {return}
				
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadInputViews()
    }
}
