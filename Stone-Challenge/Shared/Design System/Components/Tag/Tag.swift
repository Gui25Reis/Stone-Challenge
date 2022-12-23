/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit



/// Cria uma tag a partir do nome e cor
class Tag: UIView, ViewCode {
    
    /* MARK: - Atributos */

    // Views
    
    private let label: UILabel = {
        let lbl = CustomViews.newLabel(align: .center)
        lbl.textColor = UIColor(.primaryText)
        return lbl
    }()
    
    
    // Outros

    internal var dynamicConstraints: [NSLayoutConstraint] = []
    
    

    /* MARK: - Construtor */
    
    init(tagInfo: (any TagInfo)?) {
        super.init(frame: .zero)
        
        self.createView()
        self.setupTag(with: tagInfo ?? GenderTag.none)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    public var isDefaultSize = false {
        didSet {
            self.setupDynamicConstraints()
        }
    }
    
    
    public var defaultSize = CGSize(width: 70, height: 20) {
        didSet {
            self.setupDynamicConstraints()
        }
    }
    
    
    /// Configura a tag a partir das informações passadas
    /// - Parameter infos: informações da tag
    public func setupTag(with infos: any TagInfo) {
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
            fontSize: fontSize, weight: .regular
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
    
    
    internal func setupDynamicConstraints() {
        guard self.isDefaultSize else { return }
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)

        self.dynamicConstraints = [
            self.heightAnchor.constraint(equalToConstant: self.defaultSize.height),
            self.widthAnchor.constraint(equalToConstant: self.defaultSize.width),
        ]

        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    internal func setupUI() {}
    
    internal func setupStaticTexts() {}
    
    
    
    /// Pega uma imagem a partir do componente de status (UIView -> UIImage)
    /// - Parameter status: tipo do componente
    /// - Returns: imagem do componente
    static func getImage(for infos: any TagInfo) -> UIImage {
        let view: Tag = Tag(tagInfo: infos)
        
        let size = view.defaultSize
        view.bounds.size = size

        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        let image = renderer.image { render in
            view.layer.render(in: render.cgContext)
        }
        
        return image
    }
    
  /*
    /// Pega uma imagem a partir do componente de status (UIView -> UIImage)
    /// - Parameter status: tipo do componente
    /// - Returns: imagem do componente
    static func getImage(for status: String) -> UIImage {
        for item in StatusViewStyle.allCases {
            if status == item.word {
                return Self.getImage(for: item)
            }
        }
        
        return UIImage()
    }
   */
}
