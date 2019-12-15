import Core
import UIKit
import CoreData

class AppDependencies {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RandomUser")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    init() {
        ServiceLocator.sharedLocator.register(CoreDataStore(container: persistentContainer))
        ServiceLocator.sharedLocator.register(UserRepository(store: ServiceLocator.inject()) as UserRepositoryProtocol)        
    }
    
    func start(_ window: UIWindow?) -> Void {
        let userList = UserListModule.build()
        window?.rootViewController =  UINavigationController(rootViewController: userList)
    }
}
