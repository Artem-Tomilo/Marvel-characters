//
//  CharacterPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import Foundation

class CharacterListPresenter: CharacterPresenterProtocol {
    
    //MARK: - Properties
    
    var client: Client
    var characters: [Character] = []
    var isLoading = false
    private var pageCounter = 0
    
    private weak var view: CharacterListViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol
    private let manager = FirestoreManager.shared
    
    //MARK: - Init
    
    required init(view: CharacterListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, client: Client) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.client = client
        print(client.favoriteCharactersID)
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
    
    func accountTap(client: Client) {
        router.moveToAccount(client: client)
    }
    
    func addToFavorites(_ character: Character) {
        client.favoriteCharactersID.append(character.id)
        manager.saveCharacter(client)
    }
}
