struct StreetDTO: Decodable {
    let name: String
    let number: Int
    
    enum CodingKeys: String, CodingKey {
        case name, number
    }
}

struct LocationDTO: Decodable {
    let city: String
    let state: String
    let street: StreetDTO
    
    enum CodingKeys: String, CodingKey {
        case street, city, state
    }
}
