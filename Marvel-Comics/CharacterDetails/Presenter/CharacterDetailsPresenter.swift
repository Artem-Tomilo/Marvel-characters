//
//  CharacterDetailsPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import Foundation

class CharacterDetailsPresenter: CharacterDetailsPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: CharacterDetailsViewProtocol?
    let networkService: NetworkServiceProtocol
    let router: RouterProtocol
    var character: Character?
    var comics: [Comic]?
    
    //MARK: - Init
    
    required init(view: CharacterDetailsViewProtocol, networkService: NetworkServiceProtocol,
                  router: RouterProtocol, character: Character?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.character = character
    }
    
    //MARK: - Functions
    
    func getComics() {
        guard let character else { return }
        networkService.getComics(id: character.id) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let comics):
                    self.comics = comics
                    self.view?.getComicsSuccess()
                case .failure(let error):
                    self.view?.getComicsFailure(error: error)
                }
            }
        }
    }
    
    func backButtonTap() {
        router.popViewController()
    }
}
