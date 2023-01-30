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
    
    required init(view: SignUpViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func backButtonTap() {
        router.popViewController()
    }
}
