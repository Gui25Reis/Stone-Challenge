/* Gui Reis    -    gui.sreis25@gmail.com */


/// Modelo de dados usado para as informações dos episódios que um personagem tem parissão
struct ManagedEpisodes {
    
    /* MARK: - Atributos */
    
    let count: Int
    var eps: [String]
    
    
    
    /* MARK: - Construtores */
    
    init(count: Int, eps: [String]) {
        self.count = count
        self.eps = eps
    }
    
    
    init(episodesUrl: [String]) {
        self.count = episodesUrl.count
        self.eps = []
        
        self.eps = self.getEpisodesNumber(at: episodesUrl)
    }
    
    
    
    /* MARK: - Métodos */
    
    /// Pega apenas os números dos episódios
    /// - Parameter eps: links dos episódios
    /// - Returns: lista com os númeors dos episódios
    private func getEpisodesNumber(at eps: [String]) -> [String] {
        var epsNumbers: [String] = []
        
        for ep in eps {
            let epNum = ep.strip(at: "/").last
            
            if let epNum {
                epsNumbers.append(epNum)
            }
        }
        
        return epsNumbers
    }
}
