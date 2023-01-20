//
//  ModuleBuilder.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

class ModuleBuilder: ModuleBuilderProtocol {
    
    static func createCharacterViewController() -> UIViewController {
        let view = CharacterListViewController()
        let networkService = NetworkService()
        let presenter = CharacterListPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createCharacterDetailsViewController(character: Character) -> UIViewController {
        let view = CharacterDetailsViewController()
        let networkService = NetworkService()
        let presenter = CharacterDetailsPresenter(view: view, networkService: networkService, character: character)
        view.presenter = presenter
        return view
    }
}
