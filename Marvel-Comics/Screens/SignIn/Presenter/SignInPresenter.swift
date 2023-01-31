//
//  SignInPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import Foundation
import GoogleSignIn

class SignInPresenter: SignInPresenterProtocol {
    
    private weak var view: SignInViewProtocol?
    private let router: RouterProtocol
    private let authManager = FirebaseAuthManager()
    
    required init(view: SignInViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func signIn() {
        guard let view else { return }
        do {
            view.startIndicator()
            let email = try Validator.validateTextForMissingValue(text: view.unbindEmail(), message: "Enter your email")
            let password = try Validator.validateTextForMissingValue(text: view.unbindPassword(), message: "Enter your password")
            
            authManager.signIn(email: email, password: password) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success():
                    self.router.moveToCharacterList()
                case .failure(let error):
                    view.signInFailure(error: error)
                }
            }
        } catch {
            view.signInFailure(error: error)
        }
    }
    
    func signInWithGoogle() {
        view?.startIndicator()
        authManager.signInWithGoogle(view: view as! UIViewController) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success():
                self.router.moveToCharacterList()
            case .failure(let error):
                self.view?.signInFailure(error: error)
            }
        }
    }
    
    func signUp() {
        router.moveToSignUp()
    }
}
