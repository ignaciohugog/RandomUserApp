import Foundation

@testable import RandomUserApp

class MockUser: User {
    var userID: UUID? = UUID(uuidString: "9f45952c-9efb-4194-995c-b3e2f77a4069")
    var city = "aCity"
    var state = "aState"
    var street = "aStreet"
    var name = "aName"
    var surname = "aSurname"
    var email = "anEmail"
    var picture = ""
    var thumbnail = ""
    var phone = "1234"
    var gender = "male"
    var registered = Date()
}
