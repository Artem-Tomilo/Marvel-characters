//
//  CharacterDetailsPresenterProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 22.01.23.
//

import Foundation

protocol CharacterDetailsPresenterProtocol: AnyObject {
    init(view: CharacterDetailsViewProtocol, networkService: NetworkServiceProtocol,
         router: RouterProtocol, character: Character?)
    func loadComics()
    func backButtonTap()
    var comics: [Comic]? { get set }
    var character: Character? { get set }
}
