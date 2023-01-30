//
//  SignUpViewProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 30.01.23.
//

import Foundation

protocol SignUpViewProtocol: AnyObject {
    func unbindEmail() -> String
    func unbindPassword() -> String
    func unbindRepeatPassword() -> String
    func startIndicator()
    func signUpFailure(error: Error)
}
