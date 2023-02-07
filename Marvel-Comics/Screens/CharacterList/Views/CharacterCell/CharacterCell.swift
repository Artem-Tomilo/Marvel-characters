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
    private let likeButton = UIButton()
    private let activityIndicator = ActivityIndicator()
    private var character: Character?
    private var client: Client?
    static let cellIdentifier = "character"
    
    weak var delegate: CharacterCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.likeButton.point(inside: convert(point, to: likeButton), with: event) {
            return self.likeButton
        }
        return super.hitTest(point, with: event)
    }
    
    private func setup() {
        contentView.addSubview(background)
        background.addSubview(characterImage)
        characterImage.addSubview(nameView)
        nameView.addSubview(nameLabel)
        nameView.addSubview(likeButton)
        
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
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalTo(likeButton.snp.leading).offset(-5)
            make.centerY.equalToSuperview()
        }
        likeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.trailing.bottom.equalToSuperview().inset(5)
            make.width.equalTo(likeButton.snp.height)
        }
        
        characterImage.backgroundColor = .systemGray5
        background.backgroundColor = .clear
        characterImage.clipsToBounds = true
        characterImage.layer.cornerRadius = 5
        
        nameView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "BadaBoomBB", size: 25)
        
        likeButton.addTarget(self, action: #selector(likeTapped(_:)), for: .primaryActionTriggered)
        
        activityIndicator.displayIndicator(view: contentView)
        activityIndicator.startAnimating()
    }
    
    func setData(character: Character, client: Client) {
        activityIndicator.displayIndicator(view: contentView)
        activityIndicator.startAnimating()
        
        self.character = character
        self.client = client
        
        if client.favoriteCharactersID.contains(character.id) {
            self.likeButton.setImage(UIImage(named: "like"), for: .normal)
            self.character?.isSelected = true
        } else {
            self.likeButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
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
    
    @objc func likeTapped(_ sender: UIButton) {
        guard var character,
              let client else { return }
        switch character.isSelected {
        case true:
            if !client.favoriteCharactersID.contains(character.id) {
                sender.setImage(UIImage(named: "like"), for: .normal)
                character.isSelected.toggle()
            } else {
                sender.setImage(UIImage(named: "heart"), for: .normal)
                character.isSelected.toggle()
            }
        case false:
            sender.setImage(UIImage(named: "like"), for: .normal)
            delegate?.saveCharacter(character)
            character.isSelected.toggle()
        }
    }
}
