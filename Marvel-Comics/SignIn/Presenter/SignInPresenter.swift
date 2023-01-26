//
//  SignInPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import Foundation

class SignInPresenter: SignInPresenterProtocol {
    
    weak var view: SignInViewProtocol?
    let router: RouterProtocol
    
    required init(view: SignInViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func signInTap() {
        router.moveToCharacterList()
    }
}
