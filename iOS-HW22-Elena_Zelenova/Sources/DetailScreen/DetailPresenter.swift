import Foundation

protocol DetailPresenterType {
    var view: DetailPresenterView? { get set }
    var user: User? { get set }
    var coreDataManager: CoreDataManager? { get set }
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
}
