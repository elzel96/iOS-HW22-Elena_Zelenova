import Foundation

protocol MainViewOutput {
    func createNewUser(withName: String)
    func fetchAllUsers()
    func deleteUser(_ user: User)
}

protocol MainViewInput: AnyObject {
    func updateView(with users: [User])
    func deleteUser(_ user: User)
}

class MainPresenter {
    
    // MARK: - Elements
    
    private weak var view: MainViewInput?
    private let coreDataManager = CoreDataManager()
    
    // MARK: - init
    
    init(view: MainViewInput) {
        self.view = view
    }
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    func createNewUser(withName: String) {
        if coreDataManager.save(withName) {
            fetchAllUsers()
        }
    }
    
    func fetchAllUsers() {
        guard let users = coreDataManager.fetchAllUsers() else { return }
        view?.updateView(with: users)
    }
    
    func deleteUser(_ user: User) {
        if coreDataManager.deleteUser(user) {
            //view?.deleteUser(user) это не надо тогда?
            fetchAllUsers()
        }
    }
}

