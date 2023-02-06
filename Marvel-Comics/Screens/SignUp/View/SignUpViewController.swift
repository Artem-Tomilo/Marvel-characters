//
//  SignUpViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 30.01.23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: SignUpPresenterProtocol?
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password")
    private let repeatPasswordTextField = CustomTextField(placeholder: "Repeat password")
    private let signUpButton = UIButton()
    private let activityIndicator = ActivityIndicator()
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        addingSubviewsAndSettingConstraints()
        configureSubViews()
        configureGestureRecognizer()
    }
    
    //MARK: - View settings
    
    private func configureNavigationBar(){
        let leftTitle = UILabel()
        leftTitle.text = "Sign Up"
        leftTitle.textColor = .white
        leftTitle.font = UIFont(name: "BadaBoomBB", size: 25)
        
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .white
        let image = UIImageView(image: UIImage(named: "BackButton")?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        backButton.setImage(image.image, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .primaryActionTriggered)
        
        let firstItem = UIBarButtonItem(customView: backButton)
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace,
                                                          target: nil, action: nil)
        fixedSpace.width = 10.0
        let secondItem = UIBarButtonItem(customView: leftTitle)
        navigationItem.leftBarButtonItems = [firstItem, fixedSpace, secondItem]
    }
    
    private func addingSubviewsAndSettingConstraints() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    private func configureSubViews() {
        signUpButton.layer.cornerRadius = 5
        signUpButton.backgroundColor = .black
        let signInString = NSMutableAttributedString(string: "Sign Up", attributes: [
            .font: UIFont(name: "BadaBoomBB", size: 30) as Any
        ])
        signUpButton.setAttributedTitle(signInString, for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .primaryActionTriggered)
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.returnKeyType = .done
        emailTextField.addTarget(self, action: #selector(doneTapped(_:)),
                                 for: .editingDidEndOnExit)
        passwordTextField.textContentType = .password
        passwordTextField.returnKeyType = .done
        passwordTextField.addTarget(self, action: #selector(doneTapped(_:)),
                                    for: .editingDidEndOnExit)
        passwordTextField.isSecureTextEntry = true
        
        repeatPasswordTextField.textContentType = .password
        repeatPasswordTextField.returnKeyType = .done
        repeatPasswordTextField.addTarget(self, action: #selector(doneTapped(_:)),
                                          for: .editingDidEndOnExit)
        repeatPasswordTextField.isSecureTextEntry = true
        
        activityIndicator.displayIndicator(view: view)
    }
    
    private func configureGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    //MARK: - Targets
    
    @objc func backButtonTapped(_ sender: UIButton) {
        presenter?.backButtonTap()
    }
    
    @objc func signUpButtonTapped(_ sender: UIButton) {
        presenter?.signUp()
    }
    
    @objc func doneTapped(_ sender: UIControl) {
        sender.resignFirstResponder()
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

//MARK: - extension SignUpViewProtocol

extension SignUpViewController: SignUpViewProtocol {
    
    func unbindEmail() -> String {
        if let text = emailTextField.text {
            return text
        }
        return ""
    }
    
    func unbindPassword() -> String {
        if let text = passwordTextField.text {
            return text
        }
        return ""
    }
    
    func unbindRepeatPassword() -> String {
        if let text = repeatPasswordTextField.text {
            return text
        }
        return ""
    }
    
    func startIndicator() {
        activityIndicator.startAnimating()
    }
    
    func signUpFailure(error: Error) {
        showErrorAlertController(viewController: self, error: error)
        activityIndicator.stopAnimating()
    }
}
