import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let image: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
        imageView.tintColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 11
        button.backgroundColor = .clear
        button.configuration = .bordered()
        //button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.backgroundColor = .systemFill
        textField.borderStyle = .roundedRect
        
        let iconContainer = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        iconContainer.image = UIImage(systemName: "person")
        textField.leftView = UIView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        textField.leftView?.addSubview(iconContainer)
        textField.leftView?.tintColor = .gray
        textField.leftView?.clipsToBounds = true
        textField.leftView?.contentMode = .scaleAspectFill
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let bdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Set your bday here"
        textField.backgroundColor = .systemFill
        textField.borderStyle = .roundedRect
        
        let iconContainer = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        iconContainer.image = UIImage(systemName: "calendar")
        textField.leftView = UIView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        textField.leftView?.addSubview(iconContainer)
        textField.leftView?.tintColor = .gray
        textField.leftView?.clipsToBounds = true
        textField.leftView?.contentMode = .scaleAspectFill
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let genderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Choose your gender"
        textField.backgroundColor = .systemFill
        textField.borderStyle = .roundedRect
        
        let iconContainer = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        iconContainer.image = UIImage(systemName: "person.2.circle")
        textField.leftView = UIView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        textField.leftView?.addSubview(iconContainer)
        textField.leftView?.tintColor = .gray
        textField.leftView?.clipsToBounds = true
        textField.leftView?.contentMode = .scaleAspectFill
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.backBarButtonItem?.tintColor = .gray
    }
    
    private func setupHierarchy() {
        view.addSubview(image)
        view.addSubview(nameTextField)
        view.addSubview(bdayTextField)
        view.addSubview(genderTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            bdayTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            bdayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bdayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bdayTextField.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),

            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    
    //    @objc private func buttonPressed {
    //
    //    }
}

