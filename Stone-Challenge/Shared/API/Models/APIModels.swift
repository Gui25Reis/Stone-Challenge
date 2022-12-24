/* Gui Reis    -    gui.sreis25@gmail.com */


/// Modelo de dado usado para pegar as informações iniciais da api
struct APIData: Codable {
    let info: APIInfo?
    let results: [APIResult]?
    let error: String?
}


/// Modelo de dado usado para as informações do resultado da API
struct APIInfo: Codable {
    let count: Int
    let pages: Int
}


/// Modelo de dado usado para as informações dos personagens
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


/// Modelo de dado usado para as informações de localizaçào de um personagem
struct APILocation: Codable {
    let name: String
    let url: String
}
