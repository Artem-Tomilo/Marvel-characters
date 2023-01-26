//
//  RouterProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 22.01.23.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    func initialViewController()
    func moveToCharacterList()
    func moveToCharacterDetails(character: Character)
    func popViewController()
}
