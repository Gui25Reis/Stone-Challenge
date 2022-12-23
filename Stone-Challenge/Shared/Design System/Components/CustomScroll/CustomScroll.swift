/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Cria uma scroll view e já configura ela de acordo com o tamanho que vai ser definido pra ela
class CustomScroll: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Scrool view padrão do UIKit
    public let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(.viewBack)
        return scroll
    }()
    
    /// Espaço para colocar os elementos na scroll
    public let contentView = CustomViews.newView()
    
    
    // Constraints
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    // Outros
    
    /// Tamanho da scrollView
    public var scrollContentSize = CGSize() {
        didSet {
            self.setupScroollSize()
        }
    }
        
    

    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Adiciona uma view na scroll
    /// - Parameter view: view que vai ser adicionada
    public func addViewInScroll(_ view: UIView) {
        self.contentView.addSubview(view)
        //self.contentView.addArrangedSubview(view)
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupDynamicConstraints()
        self.setupScroollSize()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Atualiza o tamanho da scroll a partir da posição do último elemento adicionado
    public func updateScrollSize() {
//        guard let superview = self.superview else { return }
//
//        var height = lastViewAdded.frame.origin.y + lastViewAdded.frame.height
//
//        if height > self.frame.height {
//            let removeSpace = superview.safeAreaInsets.bottom
//
//            if (height - removeSpace) > superview.bounds.height {
//                height -= removeSpace
//            }
//        }
//
//        if height != self.frame.height {
//            self.scrollContentSize = CGSize(
//                width: superview.bounds.width,
//                height: height
//            )
//        }
    }
    
    
    /// Configura o tamanho da scroll e a contentView dela
    private func setupScroollSize() {
        self.scroll.frame = self.bounds
        self.contentView.frame.size = self.scrollContentSize
        
        self.scroll.contentSize = self.scrollContentSize
        self.scroll.contentSize.width = 0
    }
    
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.scroll)
        self.scroll.addSubview(self.contentView)
    }
    	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let safeAreaTop = self.scroll.safeAreaInsets.top
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.scroll.topAnchor.constraint(equalTo: self.topAnchor),
            self.scroll.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scroll.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scroll.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scroll.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            
            self.contentView.topAnchor.constraint(equalTo: self.scroll.topAnchor, constant: -safeAreaTop),
            self.contentView.leftAnchor.constraint(equalTo: self.scroll.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.scroll.rightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scroll.widthAnchor),
        ]
        
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
