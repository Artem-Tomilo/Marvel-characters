//
//  SignUpPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 30.01.23.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {
    
    private weak var view: SignUpViewProtocol?
    private let router: RouterProtocol
    private let authManager = FirebaseAuthManager()
    
    required init(view: SignUpViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func backButtonTap() {
        router.popViewController()
    }
    
    private func checkPasswords(password: String, repeatPassword: String) -> Bool {
        if password == repeatPassword {
            return true
        }
        return false
    }
    
    func signUp() {
        guard let view else { return }
        do {
            view.startIndicator()
            let email = try Validator.validateTextForMissingValue(text: view.unbindEmail(), message: "Enter your email")
            let password = try Validator.validateTextForMissingValue(text: view.unbindPassword(), message: "Enter your password")
            let repeatPassword = try Validator.validateTextForMissingValue(text: view.unbindRepeatPassword(),
                                                                           message: "Repeat your password")
            
            guard checkPasswords(password: password, repeatPassword: repeatPassword) else {
                let error = BaseError(message: "Passwords do not match")
                view.signUpFailure(error: error)
                return
            }
            authManager.createUser(email: email, password: password) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success():
                    self.router.moveToCharacterList()
                case .failure(let error):
                    view.signUpFailure(error: error)
                }
            }
        } catch {
            view.signUpFailure(error: error)
        }
    }
}
