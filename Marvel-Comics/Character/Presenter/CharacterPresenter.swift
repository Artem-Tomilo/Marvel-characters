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
    private var collectionView: UICollectionView?
    private let activityIndicator = ActivityIndicator()
    private var pageCounter = 1
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
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem * 1.5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView, let controller else { return }
        controller.view.addSubview(collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(controller.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterPresenter.cellIdentifier)
        activityIndicator.displayIndicator(view: collectionView)
        activityIndicator.startAnimating()
        fetchData()
    }
    
    private func fetchData() {
        dataSource.fetchData(pageNumber: 0)
        dataSource.updateUIWithData = { [weak self] (error) in
            if let self, error == nil{
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.collectionView?.reloadData()
                    self.pageCounter += 1
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height - 160 {
            dataSource.fetchData(pageNumber: pageCounter)
        }
    }
}
