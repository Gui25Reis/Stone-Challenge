/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Cria uma stack view costumizada podendo adicionar elementos que possuem
/// a mesma largura ou altura da stack.
///
/// Por padrão todos as views que vão ser adicionadas possuem a mesma largura
/// que a stack
class CustomStack: UIStackView {
    
    /* MARK: - Atributos */
    
    /// Deixa a dimensão das views igual a da stack
    private var sameDimensionValue: Dimension
    
    
    
    /* MARK: - Construtor */
    
    /// Cria uma stack com a distribuição igual para centralizada
    /// - Parameters:
    ///   - axis: direção que os elementos vão ficar
    ///   - sameDimension: dimensão que vai ser igual a da stack
    ///
    /// A dismensão padrão é a `width`.
    init(axis: NSLayoutConstraint.Axis, sameDimension: Dimension = .width) {
        self.sameDimensionValue = sameDimension
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.axis = axis
        self.distribution = .equalSpacing
    }
    
    
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Override */
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        
        switch self.sameDimensionValue {
        case .height:
            view.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        case .width:
            view.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Pega o espaçamento entre os elementos
    /// - Parameter space: tamanho dos elementos adicionados
    /// - Returns: espaço entre os elementos
    ///
    /// Essa função só faz sentido para caso os elementos que foram adicionados na
    /// stack view forem do mesmo tamanho.
    public func getEqualSpace(for space: CGFloat) -> CGFloat {
        var superViewValue: CGFloat? = nil
        
        switch self.axis {
        case .horizontal:
            superViewValue = self.superview?.bounds.width
            
        case .vertical:
            superViewValue = self.superview?.bounds.height
            
        @unknown default: break
        }
        
        if let superViewValue {
            let totalViewsInStack = CGFloat(self.arrangedSubviews.count)
            
            let spaceToDivide: CGFloat = superViewValue - (space * totalViewsInStack)
            
            return spaceToDivide / (totalViewsInStack + 1)
        }
        return 0
    }
    
    
    public func getStackHeight(spaceBetween: CGFloat = 0) -> CGFloat {
        var height: CGFloat = 0
        
        self.arrangedSubviews.forEach() {
            height += $0.frame.height
        }
        
        let space = CGFloat(self.arrangedSubviews.count-1) * spaceBetween
        height += space
        
        return height
    }
}
