/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UIImage {
    
    

    static func downloadImage(in url: String, for view: UIImageView, fileName: String, col: UICollectionView) {
        let group = DispatchGroup()
        group.enter()
        APIManager.shared.newQuery(with: url) { result in
            defer { group.leave() }

            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue(label: "Safe image", attributes: .concurrent).async {
                        Self.saveOnDisk(image: image, with: fileName)
                    }
                    
                    group.notify(queue: .main) {
                        view.image = image
                        print("Coloquei a imagem!")
                        
                        col.reloadData()
                        col.reloadInputViews()
                    }
                    
                } else {
                    print("Deu erro na imagem")
                }

            case .failure(let erro):
                print(erro.devWarning)
            }
        }
    }
    
    
    static func saveOnDisk(image: UIImage?, with name: String) {
        let directory = try? FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false
        ) as NSURL
        
        let fileUrl = directory?.appendingPathComponent(name)
        
        let data = image?.jpegData(compressionQuality: 1)
        
        if let data, let fileUrl {
            if let _ = try? data.write(to: fileUrl) {
                print("Imagem salva! -> \(name)")
            }
        }
    }
    
    
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
