/* Gui Reis    -    gui.sreis25@gmail.com */


/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfosView: UIView, ViewCode, ViewHasTable {
    
    /* MARK: - Atributos */

    // Views
    
    private let characterImage = CustomViews.newImage()
    
    
    /// Tabela com as informações gerais do personagem
    private let infosTable = CustomTable(style: .withHeader, tag: 0)
    
    /// Tabela com as informações de local
    private let placeTable = CustomTable(style: .withHeader, tag: 1)
    
    /// Tabela com as informações dos episódiios
    private let otherTable = CustomTable(style: .withHeader, tag: 2)
    
    
    private let tableStack = CustomStack(axis: .vertical)
    
    
    // Outros

    internal var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    internal var mainTable: [CustomTable] = []
    


    /* MARK: - Construtor */
    
    init(infos: ManagedCharacter) {
        super.init(frame: .zero)
        
        self.createView()
        self.configView(with: infos)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.dynamicCall()
    }
    
    
    private func configView(with infos: ManagedCharacter) {
        self.characterImage.image = infos.image
        
        let color = UIColor(infos.status.color)
        self.characterImage.layer.borderColor = color?.cgColor
    }
    
    
    
    /* MARK: - Protocolo */

    /* View Code */
    
    internal func setupHierarchy() {
        self.addSubview(self.characterImage)
        self.addSubview(self.tableStack)
        
        self.tableStack.addArrangedSubview(self.infosTable)
        self.tableStack.addArrangedSubview(self.placeTable)
        self.tableStack.addArrangedSubview(self.otherTable)
    }
    
    
    internal func setupView() {
        if let tables = self.tableStack.arrangedSubviews as? [CustomTable] {
            self.mainTable = tables
        }
        
        self.backgroundColor = UIColor(.viewBack)
    }
    
    
    internal func setupUI() {
        self.characterImage.layer.borderWidth = 3
        self.characterImage.layer.cornerRadius = self.characterImage.frame.height/2
    }
    
    internal func setupStaticTexts() {
        self.infosTable.setHeaderTitle(for: "About")
        self.placeTable.setHeaderTitle(for: "Location")
        self.otherTable.setHeaderTitle(for: "Episodes")
    }
    
    internal func setupFonts() {
        
    }
    
    internal func setupDynamicConstraints() {
        let lateral: CGFloat = 16
        let between: CGFloat = 20
        
        let imageSquare: CGFloat = 200
        
//        let stackHeight = self.tableStack.getStackHeight(spaceBetween: 30)
        self.tableStack.spacing = 30
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)

        self.dynamicConstraints = [
            self.characterImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: between),
            self.characterImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.characterImage.heightAnchor.constraint(equalToConstant: imageSquare),
            self.characterImage.widthAnchor.constraint(equalToConstant: imageSquare),
            
            
            self.tableStack.topAnchor.constraint(equalTo: self.characterImage.bottomAnchor, constant: between),
            self.tableStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.tableStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            //self.tableStack.heightAnchor.constraint(equalToConstant: stackHeight)
        ]

        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    internal func setupStaticConstraints() {
        //NSLayoutConstraint.activate([])
    }
}
