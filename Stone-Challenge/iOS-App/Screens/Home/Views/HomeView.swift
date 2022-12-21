/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class HomeView: UIView, ViewCode, ViewHasCollection {
    
    /* MARK: - Atributos */
    
    // Views
    
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
        self.addSubview(self.mainCollection)
    }
    
    
    func setupStaticConstraints() {
        NSLayoutConstraint.activate([
            self.mainCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.mainCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.mainCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.mainCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    
    func setupView() {}
    
    func setupUI() {}
    
    func setupStaticTexts() {}
    
    func setupFonts() {}
    
    func setupDynamicConstraints() {}
}
