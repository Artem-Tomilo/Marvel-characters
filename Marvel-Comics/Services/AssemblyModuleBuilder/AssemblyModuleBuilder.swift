//
//  AssemblyModuleBuilder.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createCharacterViewController(client: Client, router: RouterProtocol) -> UIViewController {
        let view = CharacterListViewController()
        let networkService = NetworkService()
        let presenter = CharacterListPresenter(view: view, networkService: networkService, router: router, client: client)
        view.presenter = presenter
        return view
    }
    
    func createCharacterDetailsViewController(character: Character, router: RouterProtocol) -> UIViewController {
        let view = CharacterDetailsViewController()
        let networkService = NetworkService()
        let presenter = CharacterDetailsPresenter(view: view, networkService: networkService, router: router, character: character)
        view.presenter = presenter
        return view
    }
    
    func createSignInViewController(router: RouterProtocol) -> UIViewController {
        let view = SignInViewController()
        let presenter = SignInPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSignUpViewController(router: RouterProtocol) -> UIViewController {
        let view = SignUpViewController()
        let presenter = SignUpPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createAccountViewController(router: RouterProtocol, client: Client) -> UIViewController {
        let view = AccountViewController()
        let network = NetworkService()
        let presenter = AccountPresenter(view: view, router: router, network: network, client: client)
        view.presenter = presenter
        return view
    }
}
