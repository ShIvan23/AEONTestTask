//
//  AutorizationViewController.swift
//  AEONTestTask
//
//  Created by Ivan on 16.04.2021.
//

import UIKit

class AutorizationViewController: UIViewController {
    
    // MARK: - Private Properties
    private let apiManager = AEONManager()
    
    private let autorizationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Autorization"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Login"
        textField.textContentType = .username
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.enablesReturnKeyAutomatically = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(inputText), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.textContentType = .password
        textField.keyboardType = .asciiCapable
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.returnKeyType = .send
        textField.enablesReturnKeyAutomatically = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(inputText), for: .editingChanged)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Sign in", for: .normal)
        button.alpha = 0.3
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(signinPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }
    
    // MARK: - Private Methods
    @objc private func inputText() {
        
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }
        
        loginButton.isEnabled = !login.isEmpty && !password.isEmpty
        loginButton.alpha = loginButton.isEnabled ? 1 : 0.3
    }
    
    @objc private func signinPressed() {
        
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }
        
        apiManager.signin(login: login, password: password) { (result) in
            switch result {
            case .success(let token):
                print(token.response.token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [autorizationLabel, loginTextField, passwordTextField, loginButton].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        
        let leftAndRightInsets: CGFloat = 15
        let topAndBottomInsets: CGFloat = 40
        let heightTextFields: CGFloat = 40
        
        NSLayoutConstraint.activate([autorizationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAndBottomInsets),
                                     autorizationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
                                     loginTextField.topAnchor.constraint(equalTo: autorizationLabel.bottomAnchor, constant: 30),
                                     loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftAndRightInsets),
                                     loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftAndRightInsets),
                                     loginTextField.heightAnchor.constraint(equalToConstant: heightTextFields),
        
                                     passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
                                     passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
                                     passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
                                     passwordTextField.heightAnchor.constraint(equalToConstant: heightTextFields),
        
                                     loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -topAndBottomInsets * 2),
                                     loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     loginButton.widthAnchor.constraint(equalToConstant: 200)])
    }
    
}

// MARK: - Text Field Delegate
extension AutorizationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            signinPressed()
        }
        
        return true
    }
}
