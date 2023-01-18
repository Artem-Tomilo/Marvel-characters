//
//  CollectionViewDataSource.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var array = [1, 2, 3, 4, 5, 6, 7]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterPresenter.cellIdentifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        cell.bindText(String(array[indexPath.row]))
        return cell
    }
}
