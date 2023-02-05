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
    private let authManager = FirebaseAuthManager.shared
    private let firestoreManager = FirestoreManager.shared
    
    required init(view: SignInViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    private func validateEnateredValues() -> AuthModel? {
        guard let view else { return nil }
        do {
            let email = try Validator.validateTextForMissingValue(text: view.unbindEmail(), message: "Enter your email")
            let password = try Validator.validateTextForMissingValue(text: view.unbindPassword(), message: "Enter your password")
            let model = AuthModel(email: email, password: password)
            return model
        } catch {
            view.signInFailure(error: error)
        }
        return nil
    }
    
    func signIn() {
        guard let view else { return }
        view.startIndicator()
        guard let model = validateEnateredValues() else { return }
        authManager.signIn(email: model.email, password: model.password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                self.firestoreManager.getUser(by: user.uid) { person in
                    self.router.moveToCharacterList(person: person)
                }
            case .failure(let error):
                view.signInFailure(error: error)
            }
        }
    }
    
    func signInWithGoogle() {
        view?.startIndicator()
        authManager.signInWithGoogle(view: view as! UIViewController) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success():
                print(123)
                //                self.router.moveToCharacterList()
            case .failure(let error):
                self.view?.signInFailure(error: error)
            }
        }
    }
    
    func signUp() {
        router.moveToSignUp()
    }
}
