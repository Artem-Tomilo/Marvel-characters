//
//  SignInViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class SignInViewController: UIViewController, SignInViewProtocol {
    
    var presenter: SignInPresenterProtocol?
    private let loginTextField = CustomTextField(placeholder: "Login")
    private let passwordTextField = CustomTextField(placeholder: "Password")
    private let signInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSignInView()
        configureGoogleButton()
    }
    
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
    
    private func configureSignInView() {
        view.backgroundColor = .white
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        
        loginTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
        }
        signInButton.layer.cornerRadius = 5
        signInButton.backgroundColor = .black
        
        let signInString = NSMutableAttributedString(string: "Sign In", attributes: [
            .font: UIFont(name: "BadaBoomBB", size: 30) as Any
        ])
        signInButton.setAttributedTitle(signInString, for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    private func configureGoogleButton() {
        let googleButton = GIDSignInButton()
        view.addSubview(googleButton)
        googleButton.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-15)
            make.centerX.equalTo(view.snp.centerX)
        }
        googleButton.style = .wide
        googleButton.colorScheme = .light
    }
    
    func unbindLogin() -> String {
        if let text = loginTextField.text {
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
    
    @objc func signInButtonTapped(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: loginTextField.unbind(), password: passwordTextField.unbind()) { [weak self] authResult, error in
            guard let self else { return }
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            self.presenter?.signInTap()
        }
    }
}
