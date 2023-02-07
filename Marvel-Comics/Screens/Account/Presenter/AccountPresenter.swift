//
//  AccountPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 5.02.23.
//

import Foundation
import FirebaseAuth

class AccountPresenter: AccountPresenterProtocol {
    
    weak var view: AccountViewProtocol?
    private let router: RouterProtocol
    private let networkService: NetworkServiceProtocol
    var client: Client
    var characters = [Character]()
    
    required init(view: AccountViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol, client: Client) {
        self.view = view
        self.router = router
        self.networkService = network
        self.client = client
    }
    
    func loadFavoritesCharacters() {
        guard client.favoriteCharactersID.count > 0 else {
            view?.loadCharactersFailure(error: BaseError(message: "You didn't add favorites characters"))
            return
        }
        
        client.favoriteCharactersID.forEach { id in
            networkService.loadCharacter(with: id) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let character):
                    self.characters.append(character)
                    if self.characters.count == self.client.favoriteCharactersID.count {
                        DispatchQueue.main.async() {
                            self.view?.loadCharactersSuccess()
                        }
                    }
                case .failure(let error):
                    self.view?.loadCharactersFailure(error: error)
                }
            }
        }
    }
    
    func characterDidTap(_ character: Character) {
        router.moveToCharacterDetails(character: character)
    }
    
    func backButtonTap() {
        router.popViewController()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            if Auth.auth().currentUser == nil {
                view?.startIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
                    self.router.initialViewController()
                }
            }
        } catch {
            view?.signOutFailure(error: BaseError(message: "Failed to log out. Try again"))
        }
    }
}
