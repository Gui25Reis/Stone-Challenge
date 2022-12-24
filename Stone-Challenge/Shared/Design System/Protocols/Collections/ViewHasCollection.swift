/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.UICollectionView
import class UIKit.UICollectionViewFlowLayout



/// Os tipos que estão de acordo com esse protocolo possuem uma collection na UI
protocol ViewHasCollection {
    
    /* MARK: - Atributos */
    
    /// Collection view que vai ser usada
    var mainCollection: CustomCollection { get set }
    
    /// Configurações do layout da collection
    var collectionFlow: UICollectionViewFlowLayout { get set }
}



extension ViewHasCollection {
    
    /* MARK: - Configurações */
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        self.mainCollection.collection.collectionViewLayout = self.collectionFlow
    }
    
    
    
    /* MARK: - Chamadas */
    
    /// Faz a configuração inicial da collection
    internal func setupCollection() {
        self.setupCollectionFlow()
    }
    
    
    
    /* MARK: - Encapsulamentos */
    
    /// Define o delegate e data source da collection
    /// - Parameter handler: tipo que lida com o dleegate E data source da collection
    public func setupCollectionHandler(with handler: CollectionHandler) {
        self.mainCollection.setupHandler(with: handler)
    }
    
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() {
        self.mainCollection.reloadCollectionData()
    }
}
