/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit



/// Cria uma tag a partir do nome e cor
class Tag: UIView, ViewCode {
    
    /* MARK: - Atributos */

    // Views
    
    private let label = CustomViews.newLabel(align: .left)
    
    
    // Outros

    internal var dynamicConstraints: [NSLayoutConstraint] = []
    
    

    /* MARK: - Construtor */
    
    init(tagInfo: TagInfo) {
        super.init(frame: .zero)
        
        self.createView()
        self.setupTag(with: tagInfo)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a tag a partir das informações passadas
    /// - Parameter infos: informações da tag
    public func setupTag(with infos: TagInfo) {
        self.label.text = infos.name
        self.backgroundColor = UIColor(infos.color)
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.dynamicCall()
    }
    
    
    
    /* MARK: - Protocolo */

    /* View Code */
    
    internal func setupHierarchy() {
        self.addSubview(self.label)
    }
    
    
    internal func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 5
    }
    
    
    
    internal func setupFonts() {
        let fontSize = self.frame.height * 0.6
        
        self.label.setupText(with: FontInfo(
            fontSize: fontSize, weight: .black
        ))
    }
    
    
    internal func setupStaticConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    
    internal func setupDynamicConstraints() {}
    
    internal func setupUI() {}
    
    internal func setupStaticTexts() {}
}
