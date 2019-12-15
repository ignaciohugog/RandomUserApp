import Foundation
import CoreData

@objc(ManagedUserItem)
class ManagedUserItem: NSManagedObject, User {
    @NSManaged var userID: UUID?
    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var street: String
    @NSManaged var name: String
    @NSManaged var surname: String
    @NSManaged var email: String
    @NSManaged var picture: String
    @NSManaged var thumbnail: String
    @NSManaged var phone: String
    @NSManaged var gender: String
    @NSManaged var registered: Date
    
    static var entityName: String {
        return "ManagedUserItem"
    }
    
    func configure(dto: UserDTO) -> Void {
        city = dto.location.city
        state = dto.location.state
        street = dto.location.street.name
        name = dto.firstName
        surname = dto.surname
        email = dto.email
        picture = dto.photo
        thumbnail = dto.thumbnail
        phone = dto.phone
        gender = dto.gender
        registered = dto.registeredDate
        userID = UUID(uuidString: dto.uuid)
    }
}
    

extension ManagedUserItem {
  @nonobjc public class func fetch() -> NSFetchRequest<ManagedUserItem> {
    return NSFetchRequest<ManagedUserItem>(entityName: entityName)
  }
}

