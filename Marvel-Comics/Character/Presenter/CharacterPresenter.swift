//
//  CharacterPresenter.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit
import SnapKit

class CharacterPresenter: NSObject, UICollectionViewDelegate {
    
    weak var controller: CharacterListViewController?
    private let dataSource = CollectionViewDataSource()
    
    private var collectionView: UICollectionView = {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem * 1.5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    
    static let cellIdentifier = "character"
    
    func configureNavigationBar(){
        controller?.navigationController?.navigationBar.barStyle = .black
        let navBar = controller?.navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barTintColor = .red
        
        let leftTitle = UILabel()
        leftTitle.text = "Comic Characters"
        leftTitle.textColor = .white
        controller?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitle)
    }
    
    func configureCollectionView() {
        guard let controller else { return }
        controller.view.addSubview(collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(controller.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterPresenter.cellIdentifier)
    }
}
