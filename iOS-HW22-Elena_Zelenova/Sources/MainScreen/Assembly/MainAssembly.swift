import Foundation

class MainAssembly {
    static func configureModule() -> MainViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
