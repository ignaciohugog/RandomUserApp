import CoreData
import PromiseKit

public class CoreDataStore {
  
    let persistentContainer: NSPersistentContainer!
    
    public init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
}

extension CoreDataStore {

    func saveUsers(dtos: [UserDTO]) -> Promise<[User]> {
        return Promise<[User]> { seal in
            let users: [User] = dtos.map {
                let user = NSEntityDescription.insertNewObject(forEntityName: ManagedUserItem.entityName,
                                                               into: backgroundContext) as! ManagedUserItem
                user.configure(dto: $0)
                return user
            }
            do {
                try backgroundContext.save()
                seal.fulfill(users)
            } catch let error {
                seal.reject(error)
            }
        }
    }
    
    func fetchUsers() -> Promise<[User]> {
        
        return Promise<[User]> { seal in
            do {
                let results = try backgroundContext.fetch(ManagedUserItem.fetch())
                seal.fulfill(results)
            } catch let error {
                seal.reject(error)
            }
        }
    }
    
    func deleteUser(_ user: User) -> Promise<Void> {
        return Promise<Void> { seal in
            guard let user = user as? ManagedUserItem else { return }
            backgroundContext.delete(user)
            do {
                try backgroundContext.save()
                seal.fulfill_()
            } catch let error {
                seal.reject(error)
            }
        }
    }
}
