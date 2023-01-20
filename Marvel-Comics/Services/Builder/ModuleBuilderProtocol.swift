//
//  ModuleBuilderProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func createCharacterViewController() -> UIViewController
    static func createCharacterDetailsViewController(character: Character) -> UIViewController
}
