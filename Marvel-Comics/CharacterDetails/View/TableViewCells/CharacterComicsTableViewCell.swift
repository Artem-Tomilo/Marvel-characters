//
//  CharacterComicsTableViewCell.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

class CharacterComicsTableViewCell: UITableViewCell {
    
    private var collectionView: UICollectionView?
    private let activityIndicator = ActivityIndicator()
    private var comics = [Comic]()
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
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(310)
        }
        
        collectionView.register(ComicCollectionViewCell.self,
                                forCellWithReuseIdentifier: ComicCollectionViewCell.comicCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func bind(comics: [Comic]) {
        self.comics = comics
        self.collectionView?.reloadData()
    }
}

extension CharacterComicsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ComicCollectionViewCell.comicCellIdentifier,
            for: indexPath) as? ComicCollectionViewCell else { return UICollectionViewCell() }
        let comic = comics[indexPath.item]
        cell.setData(comic: comic)
        return cell
    }
}
