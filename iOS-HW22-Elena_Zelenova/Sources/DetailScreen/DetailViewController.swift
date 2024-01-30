import UIKit

protocol DetailPresenterView: AnyObject {
    func setUser(_ user: User)
}

class DetailViewController: UIViewController, DetailPresenterView {
    
    var presenter: DetailPresenter?
    
    // MARK: - UI Elements
    
    private let image: UIImageView = {
        let imageContainer = UIImageView(frame: CGRect(x: 45, y: 150, width: 300, height: 300))
        imageContainer.layer.cornerRadius = 150
        imageContainer.layer.borderColor = UIColor.black.cgColor
        imageContainer.layer.borderWidth = 1
        imageContainer.image = UIImage(systemName: "person.fill")
        imageContainer.tintColor = UIColor.init(cgColor: CGColor(red: 1.000, green: 0.502, blue: 0.502, alpha: 1.000))
        imageContainer.clipsToBounds = true
        return imageContainer
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.layer.cornerRadius = 11
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        //button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .black
        textField.isUserInteractionEnabled = false
        
        let underlineLayer = CALayer()
        underlineLayer.backgroundColor = UIColor.systemGray3.cgColor
        underlineLayer.frame = CGRect(x: 0, y: 50, width: 350, height: 1)
        textField.layer.addSublayer(underlineLayer)
        
        let iconContainer = UIImageView(frame: CGRect(x: 0, y: 3, width: 35, height: 32))
        iconContainer.image = UIImage(systemName: "person")
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        textField.leftView?.addSubview(iconContainer)
        textField.leftView?.tintColor = .gray
        textField.leftView?.clipsToBounds = true
        textField.leftView?.contentMode = .scaleAspectFill
        textField.leftViewMode = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let bdayTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Birthday"
        textField.tintColor = .black
        textField.isUserInteractionEnabled = false
        
        let underlineLayer = CALayer()
        underlineLayer.backgroundColor = UIColor.systemGray3.cgColor
        underlineLayer.frame = CGRect(x: 0, y: 50, width: 350, height: 1)
        textField.layer.addSublayer(underlineLayer)
        
        let iconContainer = UIImageView(frame: CGRect(x: 0, y: 3, width: 35, height: 32))
        iconContainer.image = UIImage(systemName: "calendar")
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        textField.leftView?.addSubview(iconContainer)
        textField.leftView?.tintColor = .gray
        textField.leftView?.clipsToBounds = true
        textField.leftView?.contentMode = .scaleAspectFill
        textField.leftViewMode = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let genderTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Gender"
        textField.tintColor = .black
        textField.isUserInteractionEnabled = false
        
        let underlineLayer = CALayer()
        underlineLayer.backgroundColor = UIColor.systemGray3.cgColor
        underlineLayer.frame = CGRect(x: 0, y: 50, width: 350, height: 1)
        textField.layer.addSublayer(underlineLayer)
        
        let iconContainer = UIImageView(frame: CGRect(x: 0, y: 3, width: 35, height: 32))
        iconContainer.image = UIImage(systemName: "person.2.circle")
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        textField.leftView?.addSubview(iconContainer)
        textField.leftView?.tintColor = .gray
        textField.leftView?.clipsToBounds = true
        textField.leftView?.contentMode = .scaleAspectFill
        textField.leftViewMode = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        presenter?.fetchUser()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupHierarchy() {
        view.addSubview(editButton)
        view.addSubview(image)
        view.addSubview(nameTextField)
        view.addSubview(bdayTextField)
        view.addSubview(genderTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            editButton.widthAnchor.constraint(equalToConstant: 80),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 40),
            
            nameTextField.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalToConstant: 350),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            bdayTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            bdayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bdayTextField.widthAnchor.constraint(equalToConstant: 350),
            bdayTextField.heightAnchor.constraint(equalToConstant: 50),
            
            genderTextField.topAnchor.constraint(equalTo: bdayTextField.bottomAnchor),
            genderTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderTextField.widthAnchor.constraint(equalToConstant: 350),
            genderTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setUser(_ user: User) {
        nameTextField.text = presenter?.user.name
    }
    
    // MARK: - Actions
    
    //    @objc private func buttonPressed {
    //
    //    }
}

