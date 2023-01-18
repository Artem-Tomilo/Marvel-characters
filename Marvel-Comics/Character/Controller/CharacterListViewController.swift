//
//  CharacterListViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    private let presenter = CharacterPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.controller = self
        presenter.configureNavigationBar()
        presenter.configureCollectionView()
    }
}

