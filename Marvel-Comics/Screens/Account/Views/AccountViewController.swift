//
//  AccountViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 5.02.23.
//

import UIKit

class AccountViewController: UIViewController {
    
    var presenter: AccountPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension AccountViewController: AccountViewProtocol {
    
}
