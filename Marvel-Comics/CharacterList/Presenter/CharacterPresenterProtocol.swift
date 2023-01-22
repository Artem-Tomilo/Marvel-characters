//
//  CharacterPresenterProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 22.01.23.
//

import Foundation

protocol CharacterPresenterProtocol: AnyObject {
    init(view: CharacterListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getCharacters()
    func characterTap(character: Character)
    var characters: [Character] { get set }
}
