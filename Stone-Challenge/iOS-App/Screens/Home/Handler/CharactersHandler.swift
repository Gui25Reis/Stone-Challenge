/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class CharactersHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    /// Comunicação com a controller
    private weak var homeDelegate: HomeDelegate?
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Dados que vào ser usados na collection
    public var mainData: [String] = [] {
        didSet {
            self.setupDatas()
        }
    }
    
    
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
        cell.setupCell(with: data)
        
        return cell
    }
    
    
    
    /* MARK: - Delegate */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homeDelegate?.openCharacterPage(at: indexPath.row)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura os dados da tabela
    private func setupDatas() {
        
    }
}
