import Foundation

public struct UserDTO: Decodable {
    let uuid: String
    let firstName: String
    let surname: String
    let email: String
    let photo: String
    let phone: String
    let gender: String
    let thumbnail: String
    let location: LocationDTO
    let registeredDate: Date
    
    enum CodingKeys: String, CodingKey {
        case email, phone, gender, name, picture, location, registered, login
    }
    
    enum login: String, CodingKey { case uuid }
    enum registered: String, CodingKey { case date }
    enum name: String, CodingKey { case first, last }
    enum picture: String, CodingKey { case thumbnail, medium }
}

extension UserDTO {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let loginInfo = try values.nestedContainer(keyedBy: login.self, forKey: .login)
        let nameInfo = try values.nestedContainer(keyedBy: name.self, forKey: .name)
        let pictureInfo = try values.nestedContainer(keyedBy: picture.self, forKey: .picture)
        let registerInfo = try values.nestedContainer(keyedBy: registered.self, forKey: .registered)
        
        email = try values.decode(String.self, forKey: .email)
        phone = try values.decode(String.self, forKey: .phone)
        gender = try values.decode(String.self, forKey: .gender)
        location = try values.decode(LocationDTO.self, forKey: .location)
        
        uuid = try loginInfo.decode(String.self, forKey: .uuid)
        firstName = try nameInfo.decode(String.self, forKey: .first)
        surname = try nameInfo.decode(String.self, forKey: .last)
        photo = try pictureInfo.decode(String.self, forKey: .medium)
        thumbnail = try pictureInfo.decode(String.self, forKey: .thumbnail)
        registeredDate = try registerInfo.decode(Date.self, forKey: .date)
        
    }
}

extension UserDTO: Hashable {
    public static func == (lhs: UserDTO, rhs: UserDTO) -> Bool {
        return lhs.firstName == rhs.firstName
            && lhs.surname == rhs.surname
            && lhs.email == rhs.email
            && lhs.photo == rhs.photo
            && lhs.gender == rhs.gender
            && lhs.thumbnail == rhs.thumbnail
            && lhs.registeredDate == rhs.registeredDate
    }
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(email)
        hasher.combine(surname)
        hasher.combine(firstName)
        hasher.combine(registeredDate)
    }
}

public struct Result: Decodable {
    public var results: [UserDTO]
}
