/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI da célula da tabela de informações de um personagem
class InfosCell: GeneralTableCell, CustomCell {
    
    /* MARK: - Atributos */
    
    /// Tag
    private var tagView: Tag?
    
    
    // Protocolo - CustomCell
    
    static var identifier: String = "IdInfosCell"
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define a tag da célula
    public var setTagInfo: (any TagInfo)? {
        didSet {
            if let tagInfo = setTagInfo {
                self.setupTag(with: tagInfo)
            }
        }
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura a tag a partir do tipo dela
    /// - Parameter tagInfo: tipo da tag
    private func setupTag(with tagInfo: any TagInfo) {
        self.tagView = Tag(tagInfo: tagInfo)
        
        guard let tagView else { return }
        
        tagView.isDefaultSize = true
        let lateral = self.rightLateralSpace
        
        self.setupConstraint(for: tagView, with: lateral)
    }
    
    
    
    /// Adiciona o elemento na tela e define as constraints
    /// - Parameters:
    ///   - view: view que vai ser configurada
    ///   - constant: espaço lateral
    private func setupConstraint(for view: UIView, with constant: CGFloat) {
        self.contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -constant),
            view.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
}
