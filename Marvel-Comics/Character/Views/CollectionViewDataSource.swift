//
//  CollectionViewDataSource.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit

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
        let request = RequestHandler().getCharacters(pageNumber: pageNumber)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  let data else {
                print(error?.localizedDescription as Any)
                return
            }
            print(response.statusCode)
            
            let decoder = JSONDecoder()
            let result = try? decoder.decode(CharacterDataBase.self, from: data)
            
            guard let result else { return }
            let characters = result.charactersData.characters
            self.characters.append(contentsOf: characters)
            self.updateUIWithData?(error)
        }
        task.resume()
    }
}

