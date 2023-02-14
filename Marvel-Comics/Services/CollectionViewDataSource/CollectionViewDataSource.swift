//
//  CollectionViewDataSource.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import UIKit

class CollectionViewDataSource: NSObject {
    
    //MARK: - Properties
    
    private let collectionView: UICollectionView
    private var loadingView: LoadingReusableView?
    private var data = [Any]()
    private weak var delegate: CharacterCellDelegate?
    private let client: Client?
    
    //MARK: - init
    
    init(collectionView: UICollectionView, delegate: CharacterCellDelegate?, client: Client?) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.client = client
        super.init()
        collectionView.dataSource = self
        registerCells()
    }
    
    //MARK: - Functions
    
    private func registerCells() {
        collectionView.register(CharacterCell.self,
                                forCellWithReuseIdentifier: CharacterCell.cellIdentifier)
        collectionView.register(LoadingReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: LoadingReusableView.cellLoadingId)
        collectionView.register(ComicCollectionViewCell.self,
                                forCellWithReuseIdentifier: ComicCollectionViewCell.comicCellIdentifier)
    }
    
    func bindData(_ data: [Any]) {
        self.data = data
        self.collectionView.reloadData()
    }
    
    func bindLoadingView(_ loadingView: LoadingReusableView) {
        self.loadingView = loadingView
    }
}

//MARK: - extension UICollectionViewDataSource

extension CollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if data is [Character] {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.cellIdentifier,
                                                                for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
            
            let character = data[indexPath.row] as! Character
            guard let client else { return cell }
            cell.setData(character: character, client: client)
            cell.delegate = delegate
            
            if delegate == nil {
                cell.configureForAccountVC()
            }
            return cell
        } else if data is [Comic] {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.comicCellIdentifier,
                                                                for: indexPath) as? ComicCollectionViewCell else { return UICollectionViewCell() }
            let comic = data[indexPath.item] as! Comic
            cell.setData(comic: comic)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: LoadingReusableView.cellLoadingId,
                                                                             for: indexPath) as! LoadingReusableView
            if var loadingView {
                loadingView = footerView
                loadingView.backgroundColor = UIColor.clear
                return footerView
            }
        }
        return UICollectionReusableView()
    }
}
