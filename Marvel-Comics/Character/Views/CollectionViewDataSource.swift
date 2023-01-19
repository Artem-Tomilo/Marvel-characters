//
//  CollectionViewDataSource.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var updateUIWithData: ((Error?) -> Void)?
    var characters = [Character]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterPresenter.cellIdentifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        
        cell.bindText(characters[indexPath.row].name!)
        return cell
    }
}

