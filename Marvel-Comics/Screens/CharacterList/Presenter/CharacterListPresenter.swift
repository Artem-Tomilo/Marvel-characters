//
//  CharacterPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import Foundation

class CharacterListPresenter: CharacterPresenterProtocol {
    
    //MARK: - Properties
    
    var characters: [Character] = []
    private var pageCounter = 0
    var isLoading = false
    var person: Person
    
    private weak var view: CharacterListViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol
    
    //MARK: - Init
    
    required init(view: CharacterListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, person: Person) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.person = person
    }
    
    //MARK: - Functions
    
    func loadCharacters() {
        isLoading = true
        networkService.loadCharacters(pageNumber: pageCounter) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.characters.append(contentsOf: characters)
                    self.view?.loadCharactersSuccess()
                    self.isLoading = false
                    self.pageCounter += 1
                case .failure(let error):
                    self.view?.loadCharactersFailure(error: error)
                }
            }
        }
    }
    
    func characterTap(character: Character) {
        router.moveToCharacterDetails(character: character)
    }
}
