/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class Foundation.NSObject


/// Os tipo que está de acordo com esse protocolo pertence a tela de home
protocol HomeDelegate: NSObject {

    /// Abre a página do personagem
    /// - Parameter index: index da célula clicada
    func openCharacterPage(at index: Int)
}
