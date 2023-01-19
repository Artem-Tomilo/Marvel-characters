//
//  CollectionViewDataSource.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit
import Alamofire

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var updateUIWithData: ((Error?) -> Void)?
    private var characters = [Character]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterPresenter.cellIdentifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        
        let character = characters[indexPath.row]
        cell.setData(character: character)
        return cell
    }
    
    func fetchData(pageNumber: Int) {
        let url = RequestHandler().getCharacters(pageNumber: pageNumber)
        
        AF.request(url).responseDecodable(of: CharacterDataBase.self) { [weak self] response in
            guard let self else { return }
            guard response.error == nil,
                  let urlResponse = response.response else { return }
            print(urlResponse.statusCode)
            
            guard let result = try? response.result.get() else { return }
            let characters = result.charactersData.characters
            self.characters.append(contentsOf: characters)
            self.updateUIWithData?(response.error)
        }
    }
}

