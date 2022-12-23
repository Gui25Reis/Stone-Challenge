/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class Foundation.NSObject
import class UIKit.UICollectionView

import protocol UIKit.UICollectionViewDataSource
import protocol UIKit.UICollectionViewDelegateFlowLayout



/// Os tipos que estào de acordo com esse protocolo lidam com o funcionamento de uma collection,
/// tanto o delegate quanto o data source dela
protocol CollectionHandler: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// Registra uma célula
    /// - Parameter collection: collection que vai ser registrada
    func registerCell(in collection: UICollectionView)
}


extension CollectionHandler {
    
    /// Linka o data source e delegate na collection
    /// - Parameter collection: collection que vai ser linkada
    ///
    /// Essa função também faz o registro da célula
    func link(with collection: UICollectionView) {
        self.registerCell(in: collection)
        
        collection.delegate = self
        collection.dataSource = self
    }
}
