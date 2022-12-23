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
    
    
    private let filterStack = CustomStack(axis: .horizontal)
    
    
    private let scroll = CustomScroll()
    
    
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
        
        default: break
        }
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
    
    /* View Code */
    
    func setupHierarchy() {
        self.addSubview(self.scroll)
        
        self.filterStack.addArrangedSubview(self.statusFilter)
        self.filterStack.addArrangedSubview(self.genderFilter)
        self.scroll.addViewInScroll(self.filterStack)
        self.scroll.addViewInScroll(self.mainCollection)
        
        
    }
    
    
    func setupStaticConstraints() {
        NSLayoutConstraint.activate([
//            self.statusFilter.topAnchor.constraint(equalTo: self.scroll.safeAreaLayoutGuide.topAnchor),
//
//            self.genderFilter.centerYAnchor.constraint(equalTo: self.statusFilter.centerYAnchor),
//
//            self.mainCollection.topAnchor.constraint(equalTo: self.statusFilter.bottomAnchor),
//            self.mainCollection.bottomAnchor.constraint(equalTo: self.scroll.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func setupView() {
        self.backgroundColor = UIColor(.viewBack)
    }
    
    
    func setupDynamicConstraints() {
        let lateral: CGFloat = self.getEquivalent(16)
        let between: CGFloat = lateral/2
        
        let filterHeight: CGFloat = lateral*2
        
        let collectionHeight = self.mainCollection.collection.contentSize.height
        print("Altura collection: \(collectionHeight)")
        
        
        self.filterStack.spacing = lateral
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)

        self.dynamicConstraints = [
            self.scroll.topAnchor.constraint(equalTo: self.topAnchor),
            self.scroll.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scroll.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scroll.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scroll.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.filterStack.heightAnchor.constraint(equalToConstant: filterHeight),
//            self.mainCollection.heightAnchor.constraint(equalToConstant: collectionHeight),
        ]

        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    func setupUI() {
        let filterStackHeight = self.filterStack.frame.height
        let collectionHeight = self.mainCollection.collection.contentSize.height
        
        let viewHeight = filterStackHeight + collectionHeight + 16

        let viewSize = CGSize(width: self.frame.width, height: viewHeight)
        
        self.scroll.scrollContentSize = viewSize
    }
    
    func setupStaticTexts() {}
        
    func setupFonts() {}
}
