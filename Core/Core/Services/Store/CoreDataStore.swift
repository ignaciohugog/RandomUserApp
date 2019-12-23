import CoreData
import PromiseKit
import RxSwift

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

    func saveUsers(dtos: [UserDTO]) -> Single<[User]> {
        return Single<[User]>.create { single in
            let users: [User] = dtos.map {
                let user = NSEntityDescription.insertNewObject(forEntityName: ManagedUserItem.entityName,
                                                               into: self.backgroundContext) as! ManagedUserItem
                user.configure(dto: $0)
                return user
            }
            do {
                try self.backgroundContext.save()
                single(.success(users))                
            } catch let error {
                single(.error(error))
            }
            
            return Disposables.create {}
        }
    }
    
    func fetchUsers() -> Single<[User]> {
        
        return Single<[User]>.create { single in
            do {
                let results = try self.backgroundContext.fetch(ManagedUserItem.fetch())
                single(.success(results))
            } catch let error {
                single(.error(error))
            }
            return Disposables.create {}
        }
    }
    
    func deleteUser(_ user: User) -> Completable {
        return Completable.create { completable in
            let user = user as! ManagedUserItem
            self.backgroundContext.delete(user)
            do {
                try self.backgroundContext.save()
                completable(.completed)
            } catch let error {
                completable(.error(error))
            }
            return Disposables.create {}
        }
    }
    
    func searchUsers(by term: String) -> Single<[User]> {
        return Single<[User]>.create { single in
            
            let predicates = [
                NSPredicate(format: "name beginswith[cd] %@", term),
                NSPredicate(format: "email beginswith[cd] %@", term),
                NSPredicate(format: "surname beginswith[cd] %@", term)
            ]
                        
            let request = ManagedUserItem.fetch()
            request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates:predicates)
            do {
                let results = try self.backgroundContext.fetch(request)
                single(.success(results))
            } catch let error {
                single(.error(error))
            }
            return Disposables.create {}
        }
    }
}
