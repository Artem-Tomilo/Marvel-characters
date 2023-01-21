//
//  ComicCollectionViewCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    
    private let background = UIView()
    private let image = UIImageView()
    private let name = UILabel()
    private let activityIndicator = ActivityIndicator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(background)
        background.addSubview(image)
        background.addSubview(name)
        
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(160)
        }
        name.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(image.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        name.font = UIFont.boldSystemFont(ofSize: 17)
        name.textColor = .black
        name.numberOfLines = 0
        name.textAlignment = .center
        
        activityIndicator.displayIndicator(view: contentView)
        activityIndicator.startAnimating()
    }
    
    func setData(comic: Comic) {
        name.text = comic.title
        
        let path = comic.image.path
        let ext = comic.image.fileExtension
        let stringUrl = path + "." + ext
        
        image.sd_setImage(with: URL(string: stringUrl),
                          placeholderImage: nil,
                          options: .continueInBackground) { (image, error, cache, url) in
            self.activityIndicator.stopAnimating()
        }
    }
}
