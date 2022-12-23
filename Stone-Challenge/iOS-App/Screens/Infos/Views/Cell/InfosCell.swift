/* Macro - Grupo 05 */
import UIKit


/* Bibliotecas necessárias: */
class InfosCell: GeneralTableCell, CustomCell {
    
    
    private var tagView: Tag?
    
    
    static var identifier: String = "IdInfosCell"
    
    
    public var setTagInfo: (any TagInfo)? {
        didSet {
            if let tagInfo = setTagInfo {
                self.setupTag(with: tagInfo)
            }
        }
    }
    
    
    
    private func setupTag(with tagInfo: any TagInfo) {
        print("TagInfo recebida: \(tagInfo.name)")
        
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
