import UIKit

protocol DetailPresenterView: AnyObject {
    func setUser(_ user: User)
}

class DetailViewController: UIViewController, DetailPresenterView {
    
    var presenter: DetailPresenter?
    private var isEditeMode = false
    private let datePicker = UIDatePicker()
    private let genderPicker = UIPickerView()
    private let genders = ["Male", "Female", "Other"]
    private var avatar: Data? = nil
    
    // MARK: - UI Elements
    
    private var image: UIImageView = {
        let imageContainer = UIImageView(frame: CGRect(x: 45, y: 150, width: 300, height: 300))
        imageContainer.layer.cornerRadius = 150
        imageContainer.layer.borderColor = UIColor.black.cgColor
        imageContainer.layer.borderWidth = 1
        imageContainer.image = UIImage(systemName: "person.fill")
        imageContainer.tintColor = UIColor.init(cgColor: CGColor(red: 1.000, green: 0.502, blue: 0.502, alpha: 1.000))
        imageContainer.clipsToBounds = true
        imageContainer.isUserInteractionEnabled = false
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
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
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
        setupDatePicker()
        setupGenderPicker()
        setupImagePicker()
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
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 0, width: 300, height: 192)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        bdayTextField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = .black
        toolbar.setItems([doneButton], animated: false)
        bdayTextField.inputAccessoryView = toolbar
    }
    
    private func setupGenderPicker() {
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderPicker.frame = CGRect(x: 0, y: 0, width: 300, height: 192)
        genderTextField.inputView = genderPicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(genderChosen))
        doneButton.tintColor = .black
        toolbar.setItems([doneButton], animated: false)
        genderTextField.inputAccessoryView = toolbar
    }
    
    private func setupImagePicker() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        image.addGestureRecognizer(tapGesture)
    }
    
    private func saveInfo() {
        if let user = presenter?.user {
            presenter?.updateUser(user: user,
                                  image: avatar,
                                  name: nameTextField.text,
                                  bDay: bdayTextField.text,
                                  gender: genderTextField.text)
        }
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
        bdayTextField.text = presenter?.user.bdayDate
        genderTextField.text = presenter?.user.gender
    }
    
    // MARK: - Actions
    
    @objc private func editButtonPressed() {
        isEditeMode.toggle()
        if isEditeMode {
            editButton.setTitle("Save", for: .normal)
            editButton.backgroundColor = UIColor.init(cgColor: CGColor(red: 1.000, green: 0.502, blue: 0.502, alpha: 1.000))
            nameTextField.isUserInteractionEnabled = true
            bdayTextField.isUserInteractionEnabled = true
            genderTextField.isUserInteractionEnabled = true
            image.isUserInteractionEnabled = true
        } else {
            editButton.setTitle("Edit", for: .normal)
            editButton.backgroundColor = .white
            nameTextField.isUserInteractionEnabled = false
            bdayTextField.isUserInteractionEnabled = false
            genderTextField.isUserInteractionEnabled = false
            image.isUserInteractionEnabled = false
        }
        saveInfo()
    }
    
    @objc private func datePickerValueChanged() {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        bdayTextField.text = dateFormatter.string(from: selectedDate)
    }
    
    @objc private func doneButtonTapped() {
        bdayTextField.resignFirstResponder()
    }
    
    @objc private func genderChosen() {
        genderTextField.resignFirstResponder()
    }
    
    @objc private func imageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
}

// MARK: - Extensions

extension DetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return genders[row]
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
    }
}

extension DetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image.image = pickedImage
            
            DispatchQueue.main.async {
                self.avatar = pickedImage.pngData()
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
