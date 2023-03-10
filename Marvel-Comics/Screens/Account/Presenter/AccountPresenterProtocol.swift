//
//  AccountPresenterProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 5.02.23.
//

import Foundation

protocol AccountPresenterProtocol: AnyObject {
    init(view: AccountViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol, client: Client)
    func backButtonTap()
    func signOut()
    func loadFavoritesCharacters()
    func characterDidTap(_ character: Character)
    var client: Client { get set }
    var characters: [Character] { get set }
}
