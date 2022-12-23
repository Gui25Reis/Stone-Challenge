/* Macro - Grupo 05 */


/// Modelo de dados usado para o local de um personagem
struct ManagedLocation {
    
    /* MARK: - Atributos */
    
    var id: Int
    let name: String
    
    
    
    /* MARK: - Construtores */
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    
    init(apiLocation: APILocation) {
        self.id = -1
        
        if apiLocation.name.isEmpty {
            self.name = "Unknown"
        } else {
            self.name = apiLocation.name
        }
        
        
        if let id = self.getLocationId(at: apiLocation.url) {
            self.id = id
        }
    }
    
    
    
    /* MARK: - Métodos */
    
    /// (tenta) Pega o id da localização
    /// - Parameter url: url da localização
    /// - Returns: id da localização
    private func getLocationId(at url: String) -> Int? {
        let idLocal = url.strip(at: "/").last ?? ""
        return Int(idLocal)
    }
}
