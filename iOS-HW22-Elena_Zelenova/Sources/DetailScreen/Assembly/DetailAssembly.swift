import Foundation

class DetailAssembly {
    static func configureModule(forUser: User) -> DetailViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(user: forUser, view: view)
        view.presenter = presenter
        return view
    }
}
