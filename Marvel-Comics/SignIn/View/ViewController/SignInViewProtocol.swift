//
//  SignInViewProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 27.01.23.
//

import Foundation

protocol SignInViewProtocol: AnyObject {
    func unbindEmail() -> String
    func unbindPassword() -> String
    func startIndicator()
    func signInFailure(error: Error)
}
