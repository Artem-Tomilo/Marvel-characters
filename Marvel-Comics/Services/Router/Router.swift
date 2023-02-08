//
//  Router.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 22.01.23.
//

import UIKit

class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        guard let viewController = assemblyBuilder?.createSplashViewController(router: self) else { return }
        navigationController.viewControllers = [viewController]
    }
    
    func moveToSignIn() {
        guard let viewController = assemblyBuilder?.createSignInViewController(router: self) else { return }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToSignUp() {
        guard let signUpViewController = assemblyBuilder?.createSignUpViewController(router: self) else { return }
        navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func moveToCharacterList(client: Client) {
        guard let characterListViewController = assemblyBuilder?.createCharacterViewController(client: client, router: self) else { return }
        navigationController.pushViewController(characterListViewController, animated: true)
    }
    
    func moveToCharacterDetails(character: Character) {
        guard let characterDetailsViewController = assemblyBuilder?.createCharacterDetailsViewController(character: character,
                                                                                                         router: self) else { return }
        navigationController.pushViewController(characterDetailsViewController, animated: true)
    }
    
    func moveToAccount(client: Client) {
        guard let accountViewController = assemblyBuilder?.createAccountViewController(router: self, client: client) else { return }
        navigationController.pushViewController(accountViewController, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
