/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Elemento de UI da célula da tela inicial
class CharacterCell: UICollectionViewCell, CustomCell, ViewCode {
    
    /* MARK: - Atributos */

    /* Protocolos - Custom Cell */
        
    static let identifier = "IdCharacterCell"
    
    
    /* Protocolos - View Code */
    
    internal var dynamicConstraints: [NSLayoutConstraint] = []

    
    /* Views */
    
    /// Imagem do personagem
    private let imageView = CustomViews.newImage()
    
    /// Nome do personagem
    private let nameLabel: UILabel = {
        let lbl = CustomViews.newLabel(align: .center)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    

    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a célula a partir do dado
    /// - Parameter data: dado que a célula vai receber
    public func setupCell(with data: ManagedCharacter, col: UICollectionView) {
        if let image = data.image {
            self.imageView.image = image
            
        } else {
            UIImage.downloadImage(
                in: data.imageLink, for: self.imageView, fileName: data.imageName, col: col
            )
        }
        
        self.nameLabel.text = data.name
        
        let color = UIColor(data.status.color)
        self.backgroundColor = color?.withAlphaComponent(0.5)
        self.layer.borderColor = color?.cgColor
    }
    

    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.dynamicCall()
    }
    
    
    
    /* MARK: - Protocolo */
    
    internal func setupHierarchy() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.nameLabel)
    }
    
    
    internal func setupUI() {
        self.layer.cornerRadius = self.superview?.getEquivalent(15) ?? 15
        self.layer.borderWidth = self.superview?.getEquivalent(3) ?? 3
    }
    
    
    internal func setupStaticTexts() {
        self.imageView.image = UIImage(asset: .defaultImage)
        self.nameLabel.text = ""
    }
        
    
    internal func setupFonts() {
        self.nameLabel.setupText(with: FontInfo(
            fontSize: self.superview?.getEquivalent(20) ?? 20, weight: .regular
        ))
    }
    
    
    internal func setupDynamicConstraints() {
        let space: CGFloat = self.superview?.getEquivalent(10) ?? 10
        
        let imageSquare = self.contentView.frame.width - (space*2)
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
            self.imageView.heightAnchor.constraint(equalToConstant: imageSquare),
            self.imageView.widthAnchor.constraint(equalToConstant: imageSquare),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    internal func setupStaticConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            
            self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    
    internal func setupView() {}
}
