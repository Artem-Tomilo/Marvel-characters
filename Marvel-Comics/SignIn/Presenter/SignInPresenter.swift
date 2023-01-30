//
//  SignInPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class SignInPresenter: SignInPresenterProtocol {
    
    private weak var view: SignInViewProtocol?
    private let router: RouterProtocol
    
    required init(view: SignInViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func signIn() {
        guard let view else { return }
        do {
            view.startIndicator()
            let login = try Validator.validateTextForMissingValue(text: view.unbindEmail(), message: "Enter your email")
            let password = try Validator.validateTextForMissingValue(text: view.unbindPassword(), message: "Enter your password")
            
            Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
                guard let self else { return }
                if let error {
                    view.signInFailure(error: BaseError(message: error.localizedDescription))
                    return
                }
                self.router.moveToCharacterList()
            }
        } catch {
            view.signInFailure(error: error)
        }
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        view?.startIndicator()
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: view as! UIViewController) { signInResult, error in
            if let error {
                let baseError = BaseError(message: error.localizedDescription)
                self.view?.signInFailure(error: baseError)
            }
            self.router.moveToCharacterList()
        }
    }
    
    func signUp() {
        router.moveToSignUp()
    }
}
