/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Responsável pela criação do conjunto que compõe a collection de acordo com
/// o padrão do app.
///
/// É possível definir qual dos dois estilos vai ser criado com `CollectionStyle`:
/// sendo apenas a collection ou acompanhada de um título.
public class CustomCollection: UIView, ViewCode {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Título da collection
    public let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = .label
        return lbl
    }()
    
    /// Collection (relacionada ao título)
    public let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        
        col.showsHorizontalScrollIndicator = false
        col.showsVerticalScrollIndicator = false
        
        col.backgroundColor = .clear
        return col
    }()

    
    // Outros
    
    /// Estilo do grupo de acordo com o `CollectionStyle`.
    private var style: CollectionStyle = .complete {
        didSet {
            self.setupCollecitonStyle()
        }
    }
        
    
    // Constraints
    
    /// Espaço de diferença que a label vai ter
    private var labelSpace: CGFloat = 0
    
    
    // Protocolo - View Code
    
    internal var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    /// Inicializador podendo definir o estilo do grupo
    /// - Parameter style: estilo do grupo (padrão: .complete)
    init(style: CollectionStyle = .complete) {
        super.init(frame: .zero)
        
        self.style = style
        self.createView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Espaçamentos */
    
    /// Configura o espaço lateral da primeira e última célula
    /// - Parameter space: espaço que vai ser adicionado
    public func setPadding(for space: CGFloat) {
        self.collection.contentInset = .init(top: 0, left: space, bottom: 0, right: space)
    }
    
    
    /// Configura o espaço lateral da label
    /// - Parameter space: espaço que vai ser adicionado
    public func setLabelSpace(for space: CGFloat) {
        self.labelSpace = space
    }
    
    
    /* Collection */
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() {
        self.collection.reloadData()
        self.collection.reloadInputViews()
        self.setupDynamicConstraints()
    }
    
    
    /// Configura quem vai lidar com o data source e delegate da collection
    /// - Parameter handler: tipo que vai lidar com o data source e delegate da collection
    internal func setupHandler(with handler: CollectionHandler) {
        self.collection.delegate = handler
        self.collection.dataSource = handler
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.dynamicCall()
    }
    
    
    
    /* MARK: - Protocolo */
    
    /* View Code */
    
    internal func setupHierarchy() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.collection)
    }
    
    
    internal func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    internal func setupFonts() {
        self.titleLabel.setupText(with: FontInfo(
            fontSize: self.superview?.getEquivalent(15) ?? 15, weight: .semibold
        ))
    }
    
    
    internal func setupDynamicConstraints() {
        let between: CGFloat = self.getEquivalent(12)
        let titleLabelHeight: CGFloat = self.superview?.getEquivalent(25) ?? 0

        NSLayoutConstraint.deactivate(self.dynamicConstraints)

        switch self.style {
        case .complete:
            self.dynamicConstraints = [
                self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.labelSpace),
                self.titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),


                self.collection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between),
            ]

        case .justCollection:
            self.dynamicConstraints = []
        }

        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    internal func setupStaticConstraints() {
        switch self.style {
        case .complete:
            NSLayoutConstraint.activate([
                self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
                self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                
                
                self.collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])

        case .justCollection:
            NSLayoutConstraint.activate([
                self.collection.topAnchor.constraint(equalTo: self.topAnchor),
                self.collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
        }
    }
    
    
    internal func setupUI() {}
    
    internal func setupStaticTexts() {}
    
    
    
    /* MARK: - Configurações */
    
    /// Configura a collection a partir do estilo que ela vai receber
    private func setupCollecitonStyle() {
        switch self.style {
        case .complete:
            self.titleLabel.isHidden = false
            
        case .justCollection:
            self.titleLabel.isHidden = true
        }
    }
}
