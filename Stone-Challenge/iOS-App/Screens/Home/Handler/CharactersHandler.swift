/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class Foundation.NSObject
import struct Foundation.IndexPath

import struct CoreGraphics.CGSize

import class UIKit.UICollectionView
import class UIKit.UICollectionViewCell
import class UIKit.UICollectionViewLayout



class CharactersHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    /// Comunicação com a controller
    private weak var homeDelegate: HomeDelegate?
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Dados que vào ser usados na collection
    public var mainData: [ManagedCharacter] = []
    
    
    /// Define a comunicaçào entre o handler e a controller
    /// - Parameter delegate: protocolo de comunicação
    public func setHomeDelegate(with delegate: HomeDelegate) {
        self.homeDelegate = delegate
    }
    
    
    
    /* MARK: - Protocolo */
    
    internal func registerCell(in collection: UICollectionView) {
        collection.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
    }
    
    
    
    /* MARK: - Data Source */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        
        let data = self.mainData[indexPath.row]
        cell.setupCell(with: data, col: collectionView)
        
        return cell
    }
    
    
    
    /* MARK: - Delegate */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homeDelegate?.openCharacterPage(at: indexPath.row)
    }
    
    
    
    /* MARK: - Flow Layout */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 171, height: 190)
    }
}
