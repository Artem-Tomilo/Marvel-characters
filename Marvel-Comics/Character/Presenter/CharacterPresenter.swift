//
//  CharacterPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import Foundation

protocol CharacterViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol CharacterPresenterProtocol: AnyObject {
    init(view: CharacterViewProtocol, networkService: NetworkServiceProtocol)
    func getCharacters()
    var characters: [Character] { get set }
}

class CharacterPresenter: CharacterPresenterProtocol {
    
    var characters: [Character] = []
    private var pageCounter = 0
    var isLoading = false
    
    weak var view: CharacterViewProtocol?
    let networkService: NetworkServiceProtocol
    
    required init(view: CharacterViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getCharacters() {
        isLoading = true
        networkService.getCharacters(pageNumber: pageCounter) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    guard let characters else { return }
                    self.characters.append(contentsOf: characters)
                    self.view?.success()
                    self.isLoading = false
                    self.pageCounter += 1
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
