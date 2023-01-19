//
//  ActivityIndicator.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import UIKit
import SnapKit

class ActivityIndicator {
    
    private let indicator = UIActivityIndicatorView(style: .medium)
    
    func displayIndicator(view: UIView) {
        indicator.color = .black
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
}
