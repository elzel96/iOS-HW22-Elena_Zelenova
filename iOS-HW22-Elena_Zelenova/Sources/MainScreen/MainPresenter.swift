import UIKit

class MainPresenter {
    var users = [User]()
    private weak var view: PresenterView?
    private let coreDataManager = CoreDataManager()
    
    init(view: PresenterView) {
        self.view = view
    }
    
    func createNewUser(withName: String) {
        coreDataManager.save(withName)
    }
    
    func fetchAllUsers() {
        users = coreDataManager.fetchAllUsers() ?? []
    }
    
    func deleteUser(_ user: User) {
        coreDataManager.deleteUser(user)
    }
    
    func showDetails(user: User, navigationController: UINavigationController) {
        let viewController = DetailAssembly.configureModule(forUser: user)
        navigationController.pushViewController(viewController, animated: true)
    }
}
