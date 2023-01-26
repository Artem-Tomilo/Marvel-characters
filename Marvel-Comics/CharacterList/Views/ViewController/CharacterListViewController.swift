//
//  CharacterListViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 18.01.23.
//

import UIKit
import SnapKit
import Alamofire

class CharacterListViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: CharacterPresenterProtocol?
    private var collectionView: UICollectionView?
    private var dataSource: CollectionViewDataSource?
    lazy var loadingView = LoadingReusableView()
    private let activityIndicator = ActivityIndicator()
    private let refreshControl = UIRefreshControl()
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
    }
    
    //MARK: - View settings
    
    private func configureNavigationBar(){
        navigationController?.navigationBar.barStyle = .black
        let navBar = navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barTintColor = .red
        
        let leftTitle = UILabel()
        leftTitle.font = UIFont(name: "BadaBoomBB", size: 25)
        leftTitle.text = "Comic Characters"
        leftTitle.textColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitle)
    }
    
    private func configureCollectionView() {
        view.backgroundColor = .white
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem * 1.5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView else { return }
        view.addSubview(collectionView)
        dataSource = CollectionViewDataSource(collectionView: collectionView)
        dataSource?.bindLoadingView(loadingView)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .primaryActionTriggered)
        
        activityIndicator.displayIndicator(view: collectionView)
        activityIndicator.startAnimating()
        presenter?.loadCharacters()
    }
    
    private func handleError(error: Error) {
        let baseError = error as! BaseError
        showAlertController(message: baseError.message, viewController: self)
    }
    
    //MARK: - Targets
    
    @objc func refresh(_ sender: UIRefreshControl) {
        presenter?.loadCharacters()
        sender.endRefreshing()
    }
}

//MARK: - extension CharacterViewProtocol

extension CharacterListViewController: CharacterListViewProtocol {
    func loadCharactersSuccess() {
        guard let presenter else { return }
        activityIndicator.stopAnimating()
        dataSource?.bindData(presenter.characters)
    }
    
    func loadCharactersFailure(error: Error) {
        handleError(error: error)
        activityIndicator.stopAnimating()
    }
}
