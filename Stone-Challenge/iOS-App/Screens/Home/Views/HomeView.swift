/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class HomeView: UIView, ViewCode, ViewHasCollection {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Botão de filtrar pelo status
    private let statusFilter = FilterButton(title: "Status")
    
    /// Botão de filtrar pelo genêro
    private let genderFilter = FilterButton(title: "Gender")
    
    
    internal var mainCollection: CustomCollection = CustomCollection()
    
    
    
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
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    
    public func updateMenuTagSelected(to tagInfo: any TagInfo) {
        switch tagInfo.filter {
        case .gender:
            self.genderFilter.setActiveTag(with: tagInfo)

        case .status:
            self.statusFilter.setActiveTag(with: tagInfo)
        }
        
        print("Tag selecionada: \(tagInfo.name)")
    }
    
    
    public func setStatusFilterMenu(with menu: UIMenu) {
        self.statusFilter.setButtonMenu(with: menu)
    }
    
    
    public func setGenderFilterMenu(with menu: UIMenu) {
        self.genderFilter.setButtonMenu(with: menu)
    }

    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.dynamicCall()
    }
    
    
    
    /* MARK: - Protocolo */
    
    /* ViewHasCollection */
    
    func registerCells() {
        self.mainCollection.collection.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
    }
    
    
    /* View Code */
    
    func setupHierarchy() {
        self.addSubview(self.statusFilter)
        self.addSubview(self.genderFilter)
        self.addSubview(self.mainCollection)
    }
    
    
    func setupStaticConstraints() {
        NSLayoutConstraint.activate([
            self.statusFilter.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            self.genderFilter.centerYAnchor.constraint(equalTo: self.statusFilter.centerYAnchor),
            

            self.mainCollection.topAnchor.constraint(equalTo: self.statusFilter.bottomAnchor),
            self.mainCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
    func setupView() {
        self.backgroundColor = .systemGray6
    }
    
    
    func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(16)
        let between: CGFloat = lateral/2
        
        let filterHeight: CGFloat = lateral*2
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)

        self.dynamicConstraints = [
            self.statusFilter.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: lateral),
            self.statusFilter.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -between),
            self.statusFilter.heightAnchor.constraint(equalToConstant: filterHeight),
            
            
            self.genderFilter.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: between),
            self.genderFilter.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral),
            self.genderFilter.heightAnchor.constraint(equalToConstant: filterHeight),
            
            
            self.mainCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: lateral),
            self.mainCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -lateral)
        ]

        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    func setupUI() {}
    
    func setupStaticTexts() {}
        
    func setupFonts() {}
}
