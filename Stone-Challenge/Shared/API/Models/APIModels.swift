/* Macro - Grupo 05 */


struct APIData: Codable {
    let info: APIInfo?
    let results: [APIResult]?
    let error: String?
}


struct APIInfo: Codable {
    let count: Int
    let pages: Int
}


struct APIResult: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: APILocation
    let location: APILocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


struct APILocation: Codable {
    let name: String
    let url: String
}
