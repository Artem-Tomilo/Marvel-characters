//
//  CharacterPresenterProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 22.01.23.
//

import Foundation

protocol CharacterPresenterProtocol: AnyObject {
    init(view: CharacterListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, client: Client)
    func loadCharacters()
    func characterTap(character: Character)
    func accountTap(client: Client)
    var characters: [Character] { get set }
    var isLoading: Bool { get set }
    var client: Client { get }
}
