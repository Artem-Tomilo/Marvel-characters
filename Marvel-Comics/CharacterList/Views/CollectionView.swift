//
//  CollectionView.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

//MARK: - extension UICollectionViewDelegate

extension CharacterListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = presenter?.characters[indexPath.row]
        guard let character else { return }
        presenter?.characterTap(character: character)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView.activityIndicator.stopAnimating()
        }
    }
}

//MARK: - extension UICollectionViewDataSource

extension CharacterListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.characters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterListViewController.cellIdentifier,
                                                            for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        
        let character = presenter?.characters[indexPath.row]
        guard let character else { return cell }
        cell.setData(character: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: CharacterListViewController.cellLoadingId,
                                                                             for: indexPath) as! LoadingReusableView
            loadingView = footerView
            loadingView.backgroundColor = UIColor.clear
            return footerView
        }
        return UICollectionReusableView()
    }
}

//MARK: - extension UICollectionViewDelegateFlowLayout

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if !presenter!.isLoading {
                presenter?.loadCharacters()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let size = CGSize(width: collectionView.bounds.size.width, height: 55)
        guard let presenter else { return size }
        if presenter.isLoading {
            return CGSize.zero
        } else {
            return size
        }
    }
}
