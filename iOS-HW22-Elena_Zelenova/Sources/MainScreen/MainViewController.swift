import UIKit

class MainViewController: UIViewController {
    
 //   var mainPresenter: MainPresenter?
    
    // MARK: - UI Elements
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.backgroundColor = .systemFill
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Press", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 11
        button.backgroundColor = .systemBlue
        //button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .insetGrouped)
//        //tableView.register(TableCell.self, forCellReuseIdentifier: "cell")
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem?.tintColor = .gray
    }
    
    private func setupHierarchy() {
        view.addSubview(textField)
//        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),

            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50),
            
//            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    
    //    @objc private func buttonPressed {
    //
    //    }
}

// MARK: - Extensions

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let viewController = DetailController()
//        if let detailModel = model?[indexPath.row] {
//            viewController.detailView.model = detailModel
//        }
//        navigationController?.pushViewController(viewController, animated: true)
    }
}

//extension MainViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        model?.count ?? 0
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MarvelCell
//        if let cellModel = model?[indexPath.row] {
//            cell?.model = cellModel
//        }
//        return cell ?? UITableViewCell()
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//}

