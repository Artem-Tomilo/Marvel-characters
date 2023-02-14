//
//  CharacterDetailsHeaderTableViewCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

class CharacterDetailsHeaderTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let background = UIView()
    private let image = UIImageView()
    private let nameLabel = UILabel()
    static let headerCellIdentifier = "headerCell"
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        background.backgroundColor = .white
    }
    
    private func setup() {
        contentView.addSubview(background)
        background.addSubview(image)
        background.addSubview(nameLabel)
        
        background.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(140)
        }
        image.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(120)
        }
        nameLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(10)
            make.leading.equalTo(image.snp.trailing).offset(10)
        }
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        nameLabel.font = UIFont(name: "BadaBoomBB", size: 40)
        nameLabel.numberOfLines = 0
    }
    
    func bind(character: Character) {
        let path = character.image.path
        let ext = character.image.fileExtension
        let stringUrl = path + "." + ext
        
        image.sd_setImage(with: URL(string: stringUrl), placeholderImage: nil, options: .continueInBackground)
        nameLabel.text = character.name
    }
}
