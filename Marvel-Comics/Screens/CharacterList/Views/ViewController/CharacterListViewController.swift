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
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        let navBar = navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barTintColor = .red
        
        let leftTitle = UILabel()
        leftTitle.font = UIFont(name: "BadaBoomBB", size: 25)
        leftTitle.text = "Comic Characters"
        leftTitle.textColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitle)
        
        let userButton = UIButton(type: .custom)
        userButton.translatesAutoresizingMaskIntoConstraints = false
        userButton.tintColor = .white
        let image = UIImageView(image: UIImage(named: "user")?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        userButton.setImage(image.image, for: .normal)
        userButton.addTarget(self, action: #selector(userButtonTapped(_:)), for: .primaryActionTriggered)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userButton)
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
        dataSource = CollectionViewDataSource(collectionView: collectionView, delegate: self)
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
    
    //MARK: - Targets
    
    @objc func refresh(_ sender: UIRefreshControl) {
        presenter?.loadCharacters()
        sender.endRefreshing()
    }
    
    @objc func userButtonTapped(_ sender: UIButton) {
        guard let presenter else { return }
        presenter.accountTap(client: presenter.client)
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
        showErrorAlertController(viewController: self, error: error)
        activityIndicator.stopAnimating()
    }
}

//MARK: - extension CharacterCellDelegate

extension CharacterListViewController: CharacterCellDelegate {
    func saveCharacter(_ character: Character) {
        presenter?.addToFavorites(character)
    }
}
