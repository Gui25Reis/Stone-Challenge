/* Gui Reis    -    gui.sreis25@gmail.com */


/* Bibliotecas necessárias: */
import UIKit


/// Botão responsável por fazer um filtro a partir das opções que ele possui
class FilterButton: UIView, ViewCode {
    
    /* MARK: - Atributos */

    // Views
    
    /// Título do filtro
    private let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel(align: .left)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    /// Tag selecionada
    private let tagView = Tag(tagInfo: nil)
    
    /// Ícone de filtragem
    private let iconImage: UIImageView = {
        let imgV = CustomViews.newImage()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    /// Botão de ação do menu
    private let mainButton = CustomButton()
    
    
    // Outros

    internal var dynamicConstraints: [NSLayoutConstraint] = []
    
    

    /* MARK: - Construtor */
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.createView()
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */

    /* Ações de botões */

    ///
    public func setButtonMenu(with menu: UIMenu) {
        self.mainButton.menu = menu
    }
    
    
    public func setActiveTag(with infos: any TagInfo) {
        self.titleLabel.text = infos.filter.title
        self.tagView.setupTag(with: infos)
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
          
        self.dynamicCall()
    }
    
    
    
    /* MARK: - Protocolo */

    /* View Code */
    
    internal func setupHierarchy() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.tagView)
        self.addSubview(self.iconImage)
        self.addSubview(self.mainButton)
    }
    
    
    internal func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(.collectionBackColor)
    }
    

    internal func setupStaticTexts() {
        let menuIcon = UIImage(.options)
        self.iconImage.image = menuIcon
    }
    
    
    internal func setupFonts() {
        self.titleLabel.setupText(with: FontInfo(
            fontSize: self.superview?.getEquivalent(18) ?? 18, weight: .regular
        ))
    }
    
    
    internal func setupDynamicConstraints() {
        let space: CGFloat = 8//self.getEquivalent(8)
        
        let iconSquare: CGFloat = self.frame.height/3
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)

        self.dynamicConstraints = [
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space),
        
            
            self.iconImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space),
            self.iconImage.widthAnchor.constraint(equalToConstant: iconSquare),
            
            
            self.tagView.rightAnchor.constraint(equalTo: self.iconImage.leftAnchor, constant: -space)
        ]

        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    internal func setupStaticConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.iconImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.tagView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.tagView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            self.tagView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            
            
            self.mainButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    internal func setupUI() {}
}
