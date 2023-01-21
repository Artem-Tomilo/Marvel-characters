//
//  HeaderView.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

class HeaderView: UIView {
    
    private let background = UIView()
    private let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        addSubview(background)
        background.addSubview(title)
        
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(60)
        }
        title.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        background.backgroundColor = .red
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.textColor = .white
    }
    
    func bind(_ text: String) {
        title.text = text
    }
}
