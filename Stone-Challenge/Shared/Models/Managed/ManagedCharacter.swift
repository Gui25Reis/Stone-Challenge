/* Macro - Grupo 05 */


/// Modelo de dados usado para as informações de um personagem
struct ManagedCharacter {
    
    /* MARK: - Atributos */
    
    let id: Int
    let page: Int
    
    let name: String
    let status: StatusTag
    let gender: GenderTag
    let species: String
    let type: String
    
    let origin: ManagedLocation
    let location: ManagedLocation
    
    let imageLink: String
    let imageName: String?
    let episodes: ManagedEpisodes
    
    var isImageDownloaded: Bool {
        return self.imageName != nil
    }
    
    
    
    /* MARK: - Construtores */
    
    init(id: Int, page: Int, name: String, status: StatusTag, gender: GenderTag, species: String, type: String, origin: ManagedLocation, location: ManagedLocation, imageLink: String, imageName: String?, episodes: ManagedEpisodes) {
        self.id = id
        self.page = page
        self.name = name
        self.status = status
        self.gender = gender
        self.species = species
        self.type = type
        self.origin = origin
        self.location = location
        self.imageLink = imageLink
        self.imageName = imageName
        self.episodes = episodes
    }
    
    
    init(apiResult: APIResult) {
        self.id = apiResult.id
        self.page = 0
        self.name = apiResult.name
        self.status = StatusTag.getType(by: apiResult.status)
        self.gender = GenderTag.getType(by: apiResult.gender)
        self.species = apiResult.species
        self.type = apiResult.type
        self.origin = ManagedLocation(
            id: 0,
            name: apiResult.origin.name
        )
        self.location = ManagedLocation(
            id: 0,
            name: apiResult.location.name
        )
        self.imageLink = apiResult.image
        self.imageName = nil
        
        self.episodes = ManagedEpisodes(episodesUrl: apiResult.episode)
    }
}
