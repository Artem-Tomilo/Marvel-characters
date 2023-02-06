//
//  ErrorAlert.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

extension UIViewController {
    func showErrorAlertController(viewController: UIViewController, error: Error) {
        let baseError = error as! BaseError
        let alert = UIAlertController(title: "Error", message: baseError.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .destructive, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

