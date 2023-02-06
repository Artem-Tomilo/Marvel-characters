//
//  AccountPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 5.02.23.
//

import Foundation
import FirebaseAuth

class AccountPresenter: AccountPresenterProtocol {
    
    weak var view: AccountViewProtocol?
    private let router: RouterProtocol
    private let networkService: NetworkServiceProtocol
    private let client: Client
    
    required init(view: AccountViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol, client: Client) {
        self.view = view
        self.router = router
        self.networkService = network
        self.client = client
    }
    
    func backButtonTap() {
        router.popViewController()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            if Auth.auth().currentUser == nil {
                view?.startIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
                    self.router.initialViewController()
                }
            }
        } catch {
            view?.signOutFailure(error: BaseError(message: "Failed to log out. Try again"))
        }
    }
}
