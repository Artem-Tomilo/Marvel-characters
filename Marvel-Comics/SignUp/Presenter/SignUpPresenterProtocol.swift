//
//  SignUpPresenterProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 30.01.23.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    init(view: SignUpViewProtocol, router: RouterProtocol)
    func backButtonTap()
}
