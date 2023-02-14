//
//  CharacterCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit
import SDWebImage

class CharacterCell: UICollectionViewCell {
    
    //MARK: - Properties
    
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
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addingSubviewsAndSettingConstraints()
        configureSubViews()
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
    
    //MARK: - View settings
    
    private func addingSubviewsAndSettingConstraints() {
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
    }
    
    private func configureSubViews() {
        characterImage.backgroundColor = .systemGray5
        background.backgroundColor = .clear
        characterImage.clipsToBounds = true
        characterImage.layer.cornerRadius = 5
        
        nameView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "BadaBoomBB", size: 25)
        
        likeButton.addTarget(self, action: #selector(likeTapped(_:)), for: .primaryActionTriggered)
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        
        activityIndicator.displayIndicator(view: contentView)
        activityIndicator.startAnimating()
    }
    
    //MARK: - Functions
    
    func setData(character: Character, client: Client) {
        activityIndicator.displayIndicator(view: contentView)
        activityIndicator.startAnimating()
        
        self.character = character
        self.client = client
        
        nameLabel.text = character.name
        
        let path = character.image.path
        let ext = character.image.fileExtension
        let stringUrl = path + "." + ext
        
        characterImage.sd_setImage(with: URL(string: stringUrl),
                                   placeholderImage: nil,
                                   options: .continueInBackground) { (image, error, cache, url) in
            self.activityIndicator.stopAnimating()
        }
        
        if client.favoriteCharactersID.contains(character.id) {
            self.likeButton.setImage(UIImage(named: "like"), for: .normal)
            self.character?.isSelected = true
        } else {
            self.likeButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    func configureForAccountVC() {
        nameLabel.snp.removeConstraints()
        nameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        
        likeButton.isHidden = true
        nameLabel.font = UIFont(name: "BadaBoomBB", size: 20)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
    }
    
    //MARK: - Targets
    
    @objc func likeTapped(_ sender: UIButton) {
        guard let character else { return }
        switch character.isSelected {
        case true:
            delegate?.likeButtonTappedToDelete(character)
            sender.setImage(UIImage(named: "heart"), for: .normal)
            character.isSelected.toggle()
        case false:
            sender.setImage(UIImage(named: "like"), for: .normal)
            delegate?.likeButtonTappedToSave(character)
            character.isSelected.toggle()
        }
    }
}
