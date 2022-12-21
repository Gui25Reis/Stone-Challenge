/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Cria uma table costumizada podendo adicionar um cabeçalho ou um rodapé
///
/// Os cabeçalhos por padrão possuem apenas uma única linha com todo o texto em
/// letra maiúscula. Já os rodapés, os textos são capitalizados e sem limite de linhas,
/// o componente se adapta ao tamanho do footer.
///
/// .
///
/// Para usar o componente basta instanciar definindo o estilo da table. Os estilos
/// estão definidos em `TableStyle`.
///
/// .
///
/// Todas as funções externas estão na área (mark) de encapsulamento.
///
/// **ATENÇÃO**: Não é recomendado fazer uma configuração direta nos atributos da view,
/// faça o encapsulamento caso precise de alguma configuração que não tenha
///
class CustomTable: UIView, ViewCode {
    
    /* MARK: - Atributos */

    // Views
    
    /// Header da table
    private lazy var headerLabel: UILabel = {
        let lbl = CustomViews.newLabel(align: .left)
        lbl.textColor = .systemGray
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    /// Footer da table
    private lazy var footerLabel: UILabel = {
        let lbl = CustomViews.newLabel(align: .left)
        lbl.textColor = .systemGray
        lbl.sizeToFit()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    /// Table
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.backgroundColor = .systemGroupedBackground
        table.isScrollEnabled = false
        
        table.clipsToBounds = true
        table.layer.masksToBounds = true
        
        table.rowHeight = 44


        // Tirando o espaço do topo (header e footer)
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude

        let view = UIView(frame: frame)
        table.tableHeaderView = view
        table.tableFooterView = view
        
        // TODO: Deletar quando for aplicar o delegate das tabelas
        table.delegate = GeneralTableDelegate.shared
        
        return table
    }()
    
    
    /* Constraints */
    
    /// Constraints de altura do componente
    private var heightConstraints: [NSLayoutConstraint] = []

    
    /* UI */
    
    /// Estilo do componente
    private var style: TableStyle
    
    /// Define como a altura vai ser definida
    private var customHeight = false
    
    
    /* Protocol */
    
    var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    init(style: TableStyle) {
        self.style = style
        super.init(frame: .zero)
        
        self.createView()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define como a altura vai ser definida
    ///
    /// Em caso de positivo, a superview vai definir a altura do componente.
    public var isCustomHeight: Bool {
        set (status) { self.customHeight = status }
        get { self.customHeight }
    }
    
    
    /// Define o texto de cabeçalho da table
    /// - Parameter text: texto
    ///
    /// O texto fica apenas de uma única linha e todo em letra maiúscula
    public func setHeaderTitle(for text: String) {
        self.headerLabel.text = text.uppercased()
    }
    
    
    /// Define o texto de rodapé da table
    /// - Parameter text: texto
    public func setFooterTitle(for text: String) {
        self.footerLabel.text = text
    }
    
    
    
    /* Table */
    
    /// Define a tag da table
    /// - Parameter tag: tag
    public func setTableTag(for tag: Int) {
        self.tableView.tag = tag
    }
    
    
    /// Define o tamanho da célula da table
    /// - Parameter height: tamanho da célula
    ///
    /// Por padrão a célula possue o temanho de 44.
    public func setTableHeight(for height: CGFloat) {
        self.tableView.rowHeight = height
    }
    
    
    /// Atualiza o status da scroll
    /// - Parameter stauts: vai ou não ser escrolável
    public func updateScrollStatus(for status: Bool) {
        self.tableView.isScrollEnabled = status
    }
    
    
    /// Registra uma célula costumizada na table
    /// - Parameter cell: célula costumizada
    public func registerCell<T>(for cell: T.Type) {
        if let cell = T.self as? any CustomCell.Type {
            self.tableView.register(cell.self, forCellReuseIdentifier: cell.identifier)
        }
    }
    
    
    /// Atualiza os dados da table
    public func reloadTableData() {
        self.tableView.reloadData()
        self.tableView.reloadInputViews()
        self.setupDynamicConstraints()
    }
    
    
    /// Configura quem vai lidar com o data source e delegate da table
    /// - Parameter handler: tipo que vai lidar com o data source e delegate da table
    public func setupHandler(with handler: TableHandler) {
        self.tableView.delegate = handler
        self.tableView.dataSource = handler
    }
    
    
    /// Pega a altura da table de acordo com a quantidade de dados que ela tem
    /// - Returns: altura da table
    public func getTableHeight() -> CGFloat {
        if let data = self.tableView.dataSource as? TableHandler {
            let dataCount = data.getDataCount(for: self.tableView.tag)
            let tableHeight = CGFloat(dataCount) * self.tableView.rowHeight
            return tableHeight
        }
        return 0
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    
        self.dynamicCall()
        self.setupHeight()
    }
    

    
    /* MARK: - Configurações */
    
    internal func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    internal func setupHierarchy() {
        self.addSubview(self.tableView)
        
        switch self.style {
        case .justTable: break
            
        case .withFooter:
            self.addSubview(self.footerLabel)
            
        case .withHeader:
            self.addSubview(self.headerLabel)
            
        case .complete:
            self.addSubview(self.footerLabel)
            self.addSubview(self.headerLabel)
        }
    }
    
    
    internal func setupStaticTexts() {}
    
    
    internal func setupFonts() {
        if self.style != .justTable {
            let fontInfo = FontInfo(
                fontSize: self.superview?.getEquivalent(13) ?? 13,
                weight: .medium
            )
            
            switch style {
            case .justTable: break
                
            case .withFooter:
                self.footerLabel.setupText(with: fontInfo)
                
            case .withHeader:
                self.headerLabel.setupText(with: fontInfo)
                
            case .complete:
                self.headerLabel.setupText(with: fontInfo)
                self.footerLabel.setupText(with: fontInfo)
            }
        }
    }
        
    
    internal func setupUI() {
        self.tableView.layer.cornerRadius = self.superview?.getEquivalent(10) ?? 0
    }
    
    
    internal func setupStaticConstraints() {
        var staticConstraints: [NSLayoutConstraint] = [
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        
        switch style {
        case .justTable, .withFooter:
            staticConstraints.append(
                self.tableView.topAnchor.constraint(equalTo: self.topAnchor)
            )
            
        case .withHeader, .complete:
            staticConstraints.append(
                self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor)
            )
        }
        
        NSLayoutConstraint.activate(staticConstraints)
    }
        
    
    internal func setupDynamicConstraints() {
        let between: CGFloat = self.superview?.getEquivalent(5) ?? 5
        let lateral: CGFloat = self.superview?.getEquivalent(15) ?? 15
        
        let headerHeight: CGFloat = lateral
        
        if !self.dynamicConstraints.isEmpty {
            NSLayoutConstraint.deactivate(self.dynamicConstraints)
            self.dynamicConstraints.removeAll()
        }
        
        switch style {
        case .justTable: break
            
        case .withFooter:
            self.dynamicConstraints = [
                self.footerLabel.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: between),
                self.footerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
                self.footerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            ]
            
        case .withHeader:
            self.dynamicConstraints = [
                self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
                self.headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
                self.headerLabel.heightAnchor.constraint(equalToConstant: headerHeight),
                
                
                self.tableView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: between),
            ]
            
        case .complete:
            self.dynamicConstraints = [
                self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
                self.headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
                self.headerLabel.heightAnchor.constraint(equalToConstant: headerHeight),
                
                
                self.tableView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: between),
                
                
                self.footerLabel.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: between),
                self.footerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
                self.footerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            ]
        }
        
        if self.customHeight {
            self.dynamicConstraints.append(
                self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            )
        } else {
            self.dynamicConstraints.append(
                self.tableView.heightAnchor.constraint(equalToConstant: self.getTableHeight())
            )
        }
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura a altrua do componente
    private func setupHeight() {
        if !self.heightConstraints.isEmpty {
            NSLayoutConstraint.deactivate(self.heightConstraints)
            self.heightConstraints.removeAll()
        }
        
        if !self.customHeight {
            var viewHeight = self.tableView.bounds.height
            viewHeight += self.headerLabel.bounds.height
            viewHeight += self.footerLabel.bounds.height
            
            self.heightConstraints = [
                self.heightAnchor.constraint(equalToConstant: viewHeight)
            ]
            
            NSLayoutConstraint.activate(self.heightConstraints)
        }
    }
}
