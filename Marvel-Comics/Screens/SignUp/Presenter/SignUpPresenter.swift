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
    private let authManager = FirebaseAuthManager.shared
    private let firestoreManager = FirestoreManager.shared
    
    required init(view: SignUpViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func backButtonTap() {
        router.popViewController()
    }
    
    private func validateEnateredValues() -> AuthModel? {
        guard let view else { return nil }
        do {
            let email = try Validator.validateTextForMissingValue(text: view.unbindEmail(), message: "Enter your email")
            let password = try Validator.validateTextForMissingValue(text: view.unbindPassword(), message: "Enter your password")
            let repeatPassword = try Validator.validateTextForMissingValue(text: view.unbindRepeatPassword(),
                                                                           message: "Repeat your password")
            
            guard password == repeatPassword else {
                let error = BaseError(message: "Passwords don't match")
                view.signUpFailure(error: error)
                return nil
            }
            let model = AuthModel(email: email, password: password)
            return model
        } catch {
            view.signUpFailure(error: error)
        }
        return nil
    }
    
    func signUp() {
        guard let view else { return }
        view.startIndicator()
        guard let model = validateEnateredValues() else { return }
        authManager.createUser(email: model.email, password: model.password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                let client = Client(email: user.email ?? "", id: user.uid)
                self.firestoreManager.saveUser(client)
                self.router.moveToCharacterList(client: client)
            case .failure(let error):
                view.signUpFailure(error: error)
            }
        }
    }
}
