//
//  CustomTextField.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        borderStyle = .roundedRect
        returnKeyType = .done
        enablesReturnKeyAutomatically = true
        font = UIFont(name: "BadaBoomBB", size: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func bind(_ text: String) {
        self.text = text
    }
    
    func unbind() -> String {
        if let text {
            return text
        }
        return ""
    }
}


