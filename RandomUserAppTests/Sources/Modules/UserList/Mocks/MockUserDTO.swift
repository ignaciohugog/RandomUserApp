import Foundation
@testable import Core

extension UserDTO {
    init(name: String = "",
         surname: String = "",
         email: String = "",
         uiid: String = "9f45952c-9efb-4194-995c-b3e2f77a4069") {
        
        let streetDTO  = StreetDTO(name: "", number: 2)
        let locationDTO = LocationDTO(city: "", state: "", street: streetDTO)
        
        self.init(uuid: uiid,
                  firstName: name,
                  surname: surname,
                  email: email,
                  photo: "",
                  phone: "",
                  gender: "",
                  thumbnail: "",
                  location: locationDTO,
                  registeredDate: Date())
    }
    
    init(uiid: String) {
        self.init(name: "", surname: "", email: "", uiid: uiid)
    }
}
