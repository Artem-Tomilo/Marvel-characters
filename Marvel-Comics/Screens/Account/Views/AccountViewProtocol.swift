//
//  AccountViewProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 5.02.23.
//

import Foundation

protocol AccountViewProtocol: AnyObject {
    func startIndicator()
    func signOutFailure(error: BaseError)
    func loadCharactersSuccess()
    func loadCharactersFailure(error: Error)
}
