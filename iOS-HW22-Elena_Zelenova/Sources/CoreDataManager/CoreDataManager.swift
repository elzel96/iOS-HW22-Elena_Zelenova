import UIKit
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iOS_HW22_Elena_Zelenova")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var users: [NSManagedObject] = []
    
    private let request: NSFetchRequest<User> = User.fetchRequest()
    
    func save(_ withName: String) {
        let user = User(context: viewContext)
        user.name = withName
        saveContext()
    }
    
    func fetchAllUsers() -> [User]? {
        do {
            let users = try viewContext.fetch(request)
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func fetchUsers(withName: String) -> [User]? {
        request.predicate = NSPredicate(format: "name == %@", withName)
        
        do {
            let users = try viewContext.fetch(request)
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteUser(_ user: User) {
        viewContext.delete(user)
        saveContext ()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
