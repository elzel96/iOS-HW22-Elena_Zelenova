import UIKit

protocol PresenterView: AnyObject {}

class MainViewController: UIViewController, PresenterView {
    
    var presenter: MainViewOutput?
    private var users = [User]()
    
    // MARK: - UI Elements
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.backgroundColor = .systemFill
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 11
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem?.tintColor = .gray
        tableView.reloadData()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        
        presenter?.fetchAllUsers()
        tableView.reloadData()
    }
    
    private func setupHierarchy() {
        view.addSubview(textField)
        view.addSubview(tableView)
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
            
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func buttonPressed() {
        if let text = textField.text {
            if text.rangeOfCharacter(from: CharacterSet.letters) != nil {
                presenter?.createNewUser(withName: text)
                textField.text?.removeAll()
            } else {
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Incorrect name", message: "Please write down your name before registration using letters", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alertController, animated: true)
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func updateView(with users: [User]) {
        self.users = users
        tableView.reloadData()
    }
    
    func deleteUser(_ user: User) {
        users.removeAll(where: { $0 == user })
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = DetailAssembly.configureModule(forUser: users[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.presenter?.deleteUser(self.users[indexPath.row])
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}

