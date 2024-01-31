import UIKit
import CoreData

class CoreDataManager {
    var users: [NSManagedObject] = []
    
    private let request: NSFetchRequest<User> = User.fetchRequest()
    
    func save(_ withName: String) {
        let user = User(context: AppDelegate.viewContext)
        user.name = withName
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func updateUser(_ user: User,
                    _ image: Data?,
                    _ name: String?,
                    _ bDay: String?,
                    _ gender: String?){
        if let image = image {
            user.avatar = image
        }
        if let name = name {
            user.name = name
        }
        if let bDay = bDay {
            user.bdayDate = bDay
        }
        if let gender = gender {
            user.gender = gender
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func fetchAllUsers() -> [User]? {
        do {
            let users = try AppDelegate.viewContext.fetch(request)
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteUser(_ user: User) {
        AppDelegate.viewContext.delete(user)
        (UIApplication.shared.delegate as! AppDelegate).saveContext ()
    }
}
