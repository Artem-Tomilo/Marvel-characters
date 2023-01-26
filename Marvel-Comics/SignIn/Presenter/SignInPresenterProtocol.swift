//
//  SignInPresenterProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 27.01.23.
//

import Foundation

protocol SignInPresenterProtocol: AnyObject {
    init(view: SignInViewProtocol, router: RouterProtocol)
    func signInTap()
}
