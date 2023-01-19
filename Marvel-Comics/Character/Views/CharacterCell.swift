//
//  CharacterCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit
import SnapKit

class CharacterCell: UICollectionViewCell {
    
    private let background = UIView()
    private let characterImage = UIImageView()
    private let nameView = UIView()
    private let nameLabel = UILabel()
    private var blurEffectView = UIVisualEffectView()
    
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
        nameLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        characterImage.addSubview(blurEffectView)
    }
    
    func showImage() {
        blurEffectView.effect = .none
    }
    
    func bindText(_ text: String) {
        nameLabel.text = text
    }
}
