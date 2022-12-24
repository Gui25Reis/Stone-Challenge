/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


extension UIImage {
    
    /// Faz o download de uma imagem online
    /// - Parameters:
    ///   - url: url da imagem
    ///   - view: view que vai apresentar a imagem
    ///   - fileName: nome do arquivo para salvar no disco
    ///   - col: collection view
    ///
    /// Caso tenha uma collection ela é atualiza quando a imagem for colocada.
    static func downloadImage(in url: String, for view: UIImageView, fileName: String, col: UICollectionView?) {
        let group = DispatchGroup()
        group.enter()
        APIManager.shared.newQuery(with: url) { result in
            defer { group.leave() }

            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    Self.saveOnDisk(image: image, with: fileName)
                    
                    group.notify(queue: .main) {
                        view.image = image
                        
                        col?.reloadData()
                        col?.reloadInputViews()
                    }
                }

            case .failure(let erro):
                print(erro.devWarning)
            }
        }
    }
    
    
    /// Salva uma imagem no dispositivo
    /// - Parameters:
    ///   - image: image
    ///   - name: nome do arquivo
    static func saveOnDisk(image: UIImage?, with name: String) {
        let directory = try? FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false
        ) as NSURL
        
        let fileUrl = directory?.appendingPathComponent(name)
        
        let data = image?.jpegData(compressionQuality: 1)
        
        if let data, let fileUrl {
            let _ = try? data.write(to: fileUrl) 
        }
    }
    
    
    /// Carrega uma imagem salva no disco que foi baixada (não são considerados os assets)
    /// - Parameter imageName: nome da imagem
    /// - Returns: imagem
    static func loadFromDisk(imageName: String) -> UIImage? {
        let dir = try? FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false
        )
        
        let urlFile = dir?.absoluteString ?? ""
        let url = URL(fileURLWithPath: urlFile)
        let file = url.appendingPathComponent(imageName).path
        
        let image = UIImage(contentsOfFile: file)
        return image
    }
}
