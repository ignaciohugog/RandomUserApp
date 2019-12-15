import Foundation

public protocol User {
    var userID: UUID? { get }
    var city: String { get }
    var state: String { get }
    var street: String { get }
    var name: String { get }
    var surname: String { get }
    var email: String { get }
    var picture: String { get }
    var thumbnail: String { get }
    var phone: String { get }
    var gender: String { get }
    var registered: Date { get }
}
