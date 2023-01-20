//
//  LoadingReusableView.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {
    
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func setupUI() {
        addSubview(activityIndicator)
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
}
