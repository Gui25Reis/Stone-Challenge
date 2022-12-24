/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Elementos de UI da tela inicial
class HomeView: UIView, ViewCode, ViewHasCollection {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Botão de filtrar pelo status
    private let statusFilter = FilterButton(title: "Status")
    
    /// Botão de filtrar pelo genêro
    private let genderFilter = FilterButton(title: "Gender")
    
    /// Stack para deixar os botões de filtragem
    private let filterStack: CustomStack = {
        let stack = CustomStack(axis: .horizontal, sameDimension: .height)
        stack.distribution = .fillEqually
        return stack
    }()
    
    /// Carregar novos dados
    private lazy var reloadButton: CustomButton = {
        let bt = CustomButton()
        bt.mainColor = .systemBlue
        return bt
    }()
    
    
    internal var mainCollection: CustomCollection = CustomCollection(style: .justCollection)
    
    
    
    // Outros
    
    internal var collectionFlow: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        
        return flow
    }()
    
    
    internal var dynamicConstraints: [NSLayoutConstraint] = []



    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.createView()
        self.setupCollection()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func updateMenuTagSelected(to tagInfo: any TagInfo) {
        switch tagInfo.filter {
        case .gender:
            self.genderFilter.setActiveTag(with: tagInfo)

        case .status:
            self.statusFilter.setActiveTag(with: tagInfo)
        
        default: break
        }
    }
    
    
    /* Ações de botões */
    
    public func setStatusFilterMenu(with menu: UIMenu) {
        self.statusFilter.setButtonMenu(with: menu)
    }
    
    
    public func setGenderFilterMenu(with menu: UIMenu) {
        self.genderFilter.setButtonMenu(with: menu)
    }
    
    /// Define a ação do botão de carregar novos dados
    public func setReloadAction(target: Any?, action: Selector) -> Void {
        self.reloadButton.addTarget(target, action: action, for: .touchDown)
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.dynamicCall()
    }
    
    
    
    /* MARK: - Protocolo */
    
    /* View Code */
    
    func setupHierarchy() {
        self.addSubview(self.filterStack)
        self.addSubview(self.mainCollection)
        self.addSubview(self.reloadButton)
        
        self.filterStack.addArrangedSubview(self.statusFilter)
        self.filterStack.addArrangedSubview(self.genderFilter)
    }
    
    
    func setupStaticConstraints() {
        NSLayoutConstraint.activate([
            self.filterStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),

            self.reloadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    
    func setupView() {
        self.backgroundColor = .systemGray6
    }
    
    
    func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(16)
        let between: CGFloat = self.getEquivalent(10)
        
        let filterHeight: CGFloat = lateral*2
        let butHeight: CGFloat = self.getEquivalent(44)
        
        self.filterStack.spacing = lateral
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)

        self.dynamicConstraints = [
            self.filterStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: lateral),
            self.filterStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral),
            self.filterStack.heightAnchor.constraint(equalToConstant: filterHeight),
            
            
            self.mainCollection.topAnchor.constraint(equalTo: self.statusFilter.bottomAnchor, constant: between),
            self.mainCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: lateral),
            self.mainCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral),
            self.mainCollection.bottomAnchor.constraint(equalTo: self.reloadButton.topAnchor, constant: -between),
            
            
            self.reloadButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -between),
            self.reloadButton.heightAnchor.constraint(equalToConstant: butHeight),
            self.reloadButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ]
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    func setupUI() {
        self.reloadButton.layer.cornerRadius = self.getEquivalent(10)
    }
    
    
    func setupStaticTexts() {
        self.reloadButton.setTitle("Reload data", for: .normal)
    }
        
    
    func setupFonts() {
        self.reloadButton.setupText(with: FontInfo(
            fontSize: self.getEquivalent(18), weight: .semibold
        ))
    }
}
