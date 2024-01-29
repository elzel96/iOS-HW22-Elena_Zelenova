import Foundation
import CoreData

class CoreDataManager {
    var users: [NSManagedObject] = []
    
    private let request: NSFetchRequest<User> = User.fetchRequest()
    
    func save(_ withName: String) {
        let user = User(context: AppDelegate.viewContext)
        user.name = withName
    }
    
    func fetchAllUsers(_ withName: String) -> [User]? {
        do {
            let users = try AppDelegate.viewContext.fetch(request)
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func fetchUsers(withName: String) -> [User]? {
        request.predicate = NSPredicate(format: "name == %@", withName)
        
        do {
            let users = try AppDelegate.viewContext.fetch(request)
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteUser(user: User) {
        AppDelegate.viewContext.delete(user)
    }
}
