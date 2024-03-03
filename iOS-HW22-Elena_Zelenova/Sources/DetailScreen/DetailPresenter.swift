import Foundation

protocol DetailViewOutput {
    func fetchUser() -> User
    func updateUser(image: Data?,
                    name: String?,
                    bDay: String?,
                    gender: String?)
}

protocol DetailViewInput: AnyObject { }

class DetailPresenter: DetailViewOutput {
    weak var view: DetailViewInput?
    var user: User
    let coreDataManager = CoreDataManager()
    
    init(user: User, view: DetailViewInput) {
        self.user = user
        self.view = view
    }
    
    func fetchUser() -> User {
        user
    }
    
    func updateUser(image: Data?,
                    name: String?,
                    bDay: String?,
                    gender: String?) {
        coreDataManager.updateUser(user, image, name, bDay, gender)
    }
}
