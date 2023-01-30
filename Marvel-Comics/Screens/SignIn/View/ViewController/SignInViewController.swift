//
//  SignInViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import UIKit
import SnapKit
import FirebaseAuth
import GoogleSignIn

class SignInViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: SignInPresenterProtocol?
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password")
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    private let googleButton = GIDSignInButton()
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
        navigationController?.navigationBar.barStyle = .black
        let navBar = navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barTintColor = .red
        
        let leftTitle = UILabel()
        leftTitle.font = UIFont(name: "BadaBoomBB", size: 25)
        leftTitle.text = "Sign In"
        leftTitle.textColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitle)
    }
    
    private func addingSubviewsAndSettingConstraints() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(googleButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(emailTextField.snp.height)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
        
        googleButton.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-15)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    private func configureSubViews() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .done
        emailTextField.addTarget(self, action: #selector(doneTapped(_:)),
                                 for: .editingDidEndOnExit)
        
        passwordTextField.returnKeyType = .done
        passwordTextField.addTarget(self, action: #selector(doneTapped(_:)),
                                    for: .editingDidEndOnExit)
        passwordTextField.isSecureTextEntry = true
        
        signInButton.layer.cornerRadius = 5
        signInButton.backgroundColor = .black
        let signInString = NSMutableAttributedString(string: "Sign In", attributes: [
            .font: UIFont(name: "BadaBoomBB", size: 30) as Any
        ])
        signInButton.setAttributedTitle(signInString, for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .primaryActionTriggered)
        
        googleButton.style = .wide
        googleButton.colorScheme = .light
        googleButton.addTarget(self, action: #selector(googleButtonTapped(_:)), for: .touchDown)
        
        signUpButton.backgroundColor = .clear
        let signUpString = NSMutableAttributedString(string: "Sign Up", attributes: [
            .font: UIFont(name: "BadaBoomBB", size: 25) as Any
        ])
        signUpButton.setAttributedTitle(signUpString, for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.contentHorizontalAlignment = .right
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .primaryActionTriggered)
        
        activityIndicator.displayIndicator(view: view)
    }
    
    private func configureGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func handleError(error: Error) {
        let baseError = error as! BaseError
        showAlertController(message: baseError.message, viewController: self)
    }
    
    //MARK: - Targets
    
    @objc func signInButtonTapped(_ sender: UIButton) {
        presenter?.signIn()
    }
    
    @objc func googleButtonTapped(_ sender: GIDSignInButton) {
        presenter?.signInWithGoogle()
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

//MARK: - extension SignInViewProtocol

extension SignInViewController: SignInViewProtocol {
    
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
    
    func startIndicator() {
        activityIndicator.startAnimating()
    }
    
    func signInFailure(error: Error) {
        handleError(error: error)
        activityIndicator.stopAnimating()
    }
}
