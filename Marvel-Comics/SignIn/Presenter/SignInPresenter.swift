//
//  SignInPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

class SignInPresenter: SignInPresenterProtocol {
    
    weak var view: SignInViewProtocol?
    let router: RouterProtocol
    
    required init(view: SignInViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func signIn() {
        do {
            guard let view else { return }
            let login = try Validator.validateTextForMissingValue(text: view.unbindLogin(), message: "Enter your email")
            let password = try Validator.validateTextForMissingValue(text: view.unbindPassword(), message: "Enter your password")
            
            Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
                guard let self else { return }
                if let error {
                    self.view?.signInFailure(error: BaseError(message: error.localizedDescription))
                    return
                }
                self.router.moveToCharacterList()
            }
        } catch {
            view?.signInFailure(error: error)
        }
    }
    
    func signInWithGoogle() {
        
    }
    
    func signUp() {
        
    }
}
