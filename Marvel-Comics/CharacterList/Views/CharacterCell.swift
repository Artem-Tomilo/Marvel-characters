//
//  CharacterCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit
import SDWebImage

class CharacterCell: UICollectionViewCell {
    
    private let background = UIView()
    private let characterImage = UIImageView()
    private let nameView = UIView()
    private let nameLabel = UILabel()
    private let activityIndicator = ActivityIndicator()
    static let cellIdentifier = "character"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(background)
        background.addSubview(characterImage)
        characterImage.addSubview(nameView)
        nameView.addSubview(nameLabel)
        
        background.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        characterImage.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        nameView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        characterImage.backgroundColor = .systemGray5
        background.backgroundColor = .clear
        characterImage.clipsToBounds = true
        characterImage.layer.cornerRadius = 5
        
        nameView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "BadaBoomBB", size: 25)
        
        activityIndicator.displayIndicator(view: contentView)
        activityIndicator.startAnimating()
    }
    
    func setData(character: Character) {
        activityIndicator.displayIndicator(view: contentView)
        activityIndicator.startAnimating()
        nameLabel.text = character.name
        
        let path = character.image.path
        let ext = character.image.fileExtension
        let stringUrl = path + "." + ext
        
        characterImage.sd_setImage(with: URL(string: stringUrl),
                                   placeholderImage: nil,
                                   options: .continueInBackground) { (image, error, cache, url) in
            self.activityIndicator.stopAnimating()
        }
    }
}
