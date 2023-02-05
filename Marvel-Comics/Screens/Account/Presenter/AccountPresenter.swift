//
//  AccountPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 5.02.23.
//

import Foundation

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
    
}
