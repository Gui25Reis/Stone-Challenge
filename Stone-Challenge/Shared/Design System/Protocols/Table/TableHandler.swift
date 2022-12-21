/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import protocol UIKit.UITableViewDelegate
import protocol UIKit.UITableViewDataSource


/// Os tipos que estào de acordo com esse protocolo lidam com o funcionamento de uma table,
/// tanto o delegate quanto o data source dela
///
/// Esse protocolo adiciona o controle de quantidade de dados que uma tabela possui.
protocol TableHandler: UITableViewDataSource, UITableViewDelegate {
    
    /// Pega a quantidade de dados da tabela
    /// - Parameter dataType: tipo do dado
    /// - Returns: quantidade de dados da table
    ///
    /// O parâmetro `dataType` é em relação as tabelas que possuem mais de uma seção
    /// e possivelmente outra lista de dados.
    func getDataCount(for dataType: Int) -> Int
}
