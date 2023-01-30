//
//  SignUpViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 30.01.23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
}
