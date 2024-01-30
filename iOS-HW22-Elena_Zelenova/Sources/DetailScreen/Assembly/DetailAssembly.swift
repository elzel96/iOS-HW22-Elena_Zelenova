import Foundation

class DetailAssembly {
    static func configureModule(forUser: User) -> DetailViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view)
        view.presenter = presenter
        view.presenter?.user = forUser
        return view
    }
}
