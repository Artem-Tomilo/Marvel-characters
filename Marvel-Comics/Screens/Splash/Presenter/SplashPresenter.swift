//
//  SplashPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 7.02.23.
//

import Foundation
import FirebaseAuth

class SplashPresenter {
    
    //MARK: - Properties
    
    weak var view: SplashViewController?
    private let router: RouterProtocol
    private let firestoreManager = FirestoreManager.shared
    
    //MARK: - Init
    
    init(view: SplashViewController? = nil, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    //MARK: - functions
    
    func moveToNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            if let user = Auth.auth().currentUser {
                self.firestoreManager.getUser(by: user.uid) { client in
                    self.router.moveToCharacterList(client: client)
                }
            } else {
                self.router.moveToSignIn()
            }
        }
    }
}
