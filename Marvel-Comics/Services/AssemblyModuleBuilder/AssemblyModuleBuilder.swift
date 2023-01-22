//
//  AssemblyModuleBuilder.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createCharacterViewController(router: RouterProtocol) -> UIViewController {
        let view = CharacterListViewController()
        let networkService = NetworkService()
        let presenter = CharacterListPresenter(view: view, networkService: networkService, router: router)
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
}
