//
//  CharacterDetailsPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import Foundation

protocol CharacterDetailsViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol CharacterDetailsPresenterProtocol: AnyObject {
    init(view: CharacterDetailsViewProtocol, networkService: NetworkServiceProtocol, character: Character?)
    func getComics()
    var comics: [Comic] { get set }
}

class CharacterDetailsPresenter: CharacterDetailsPresenterProtocol {
    
    var comics: [Comic] = []
    weak var view: CharacterDetailsViewProtocol?
    let networkService: NetworkServiceProtocol
    var character: Character?
    
    required init(view: CharacterDetailsViewProtocol, networkService: NetworkServiceProtocol, character: Character?) {
        self.view = view
        self.character = character
        self.networkService = networkService
    }
    
    func getComics() {
        guard let character else { return }
        networkService.getComics(id: character.id) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let comics):
                    self.comics = comics
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
