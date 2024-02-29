import Foundation

protocol DetailPresenterView: AnyObject {}

protocol DetailPresenterType {
    var view: DetailPresenterView? { get set }
    var user: User? { get set }
    var coreDataManager: CoreDataManager? { get set }
    func updateUser(user: User,
                    image: Data?,
                    name: String?,
                    bDay: String?,
                    gender: String?)
}

class DetailPresenter {
    weak var view: DetailPresenterView?
    var user = User()
    let coreDataManager = CoreDataManager()
    
    init(view: DetailPresenterView) {
        self.view = view
    }
    
    func fetchUser() {
        view?.setUser(user)
    }
    
    func updateUser(user: User,
                    image: Data?,
                    name: String?,
                    bDay: String?,
                    gender: String?) {
        coreDataManager.updateUser(user, image, name, bDay, gender)
    }
}
