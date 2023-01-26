//
//  CharacterComicsTableViewCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

class CharacterComicsTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView?
    private var dataSource: CollectionViewDataSource?
    private let activityIndicator = ActivityIndicator()
    static let characterComicsCellIdentifier = "chatacterComicsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 130, height: 290)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10.0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        guard let collectionView else { return }
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(collectionView)
        dataSource = CollectionViewDataSource(collectionView: collectionView)
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(310)
        }
    }
    
    func bind(comics: [Comic]) {
        self.dataSource?.bindData(comics)
        self.collectionView?.reloadData()
    }
}
