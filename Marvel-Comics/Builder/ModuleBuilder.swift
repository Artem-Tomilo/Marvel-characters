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
        let presenter = CharacterPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
