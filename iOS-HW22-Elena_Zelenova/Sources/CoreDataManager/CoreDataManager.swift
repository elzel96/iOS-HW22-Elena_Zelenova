import UIKit
import CoreData

class CoreDataManager {
    var users: [NSManagedObject] = []
    private let request: NSFetchRequest<User> = User.fetchRequest()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(_ withName: String) -> Bool {
        let user = User(context: context)
        user.name = withName
        do {
            try context.save()
            return true
        } catch {
            print("Ошибка при cохранении пользователя: \(error), \(error.localizedDescription)")
            return false
        }
    }
    
    func updateUser(_ user: User,
                    _ image: Data?,
                    _ name: String?,
                    _ bDay: String?,
                    _ gender: String?) -> Bool {
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
        do {
            try context.save()
            return true
        } catch {
            print("Ошибка при обновлении пользователя: \(error), \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchAllUsers() -> [User]? {
        do {
            let users = try context.fetch(request)
            return users
        } catch {
            print("Ошибка при загрузке данных: \(error), \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteUser(_ user: User) -> Bool {
        context.delete(user)
        do {
            try context.save()
            return true
        } catch {
            print("Ошибка при удалении пользователя: \(error), \(error.localizedDescription)")
            return false
        }
    }
}

