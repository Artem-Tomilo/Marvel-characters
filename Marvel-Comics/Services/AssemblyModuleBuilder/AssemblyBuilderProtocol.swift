//
//  AssemblyBuilderProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createCharacterViewController(client: Client, router: RouterProtocol) -> UIViewController
    func createCharacterDetailsViewController(character: Character, router: RouterProtocol) -> UIViewController
    func createSignInViewController(router: RouterProtocol) -> UIViewController
    func createSignUpViewController(router: RouterProtocol) -> UIViewController
}
