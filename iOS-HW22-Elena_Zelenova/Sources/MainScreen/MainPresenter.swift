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
        coreDataManager.save(withName)
        view?.updateView(with: coreDataManager.fetchAllUsers() ?? [])
    }
    
    func fetchAllUsers() {
        guard let users = coreDataManager.fetchAllUsers() else { return }
        view?.updateView(with: users)
    }
    
    func deleteUser(_ user: User) {
        coreDataManager.deleteUser(user)
        view?.deleteUser(user)
    }
}

