import CoreData

class MockPersistantContainer: NSPersistentContainer {
    init() {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        super.init(name: "RandomUserContainer", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        self.persistentStoreDescriptions = [description]
        self.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("\(error)")
            }
        }
    }
}
