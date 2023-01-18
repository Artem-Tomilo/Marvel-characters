//
//  CharacterCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit

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
        [background, characterImage, nameView, nameLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(background)
        background.addSubview(characterImage)
        characterImage.addSubview(nameView)
        nameView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            background.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            characterImage.heightAnchor.constraint(equalTo: background.heightAnchor),
            characterImage.widthAnchor.constraint(equalTo: background.widthAnchor),
            
            nameView.leadingAnchor.constraint(equalTo: characterImage.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: characterImage.trailingAnchor),
            nameView.bottomAnchor.constraint(equalTo: characterImage.bottomAnchor),
            nameView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor)
        ])
        
        characterImage.backgroundColor = .systemGray5
        background.backgroundColor = .clear
        characterImage.clipsToBounds = true
        characterImage.layer.cornerRadius = 5
        
        nameView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
//        addBlurEffect()
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = characterImage.bounds
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: characterImage.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: characterImage.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: characterImage.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: nameView.topAnchor)
        ])
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        characterImage.addSubview(blurEffectView)
    }
    
    func showImage() {
        blurEffectView.effect = .none
    }
    
    func bind(data: Data) {
        characterImage.image = UIImage(data: data)
    }
    
    func bindText(_ text: String) {
        nameLabel.text = text
    }
}
