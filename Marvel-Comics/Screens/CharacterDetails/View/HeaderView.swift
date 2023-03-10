//
//  HeaderView.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

class HeaderView: UIView {
    
    //MARK: - Properties
    
    private let background = UIView()
    private let title = UILabel()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Functions
    
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
        title.font = UIFont(name: "BadaBoomBB", size: 30)
        title.textColor = .white
    }
    
    func bind(_ text: String) {
        title.text = text
    }
}
