//
//  CharacterDescriptionTableViewCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

class CharacterDescriptionTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let descriptionLabel = UILabel()
    static let descriptionCellIdentifier = "descriptionCell"
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Functions
    
    private func setup() {
        contentView.backgroundColor = .white
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        descriptionLabel.textColor = .black
    }
    
    func bind(_ text: String) {
        descriptionLabel.text = text
    }
}
