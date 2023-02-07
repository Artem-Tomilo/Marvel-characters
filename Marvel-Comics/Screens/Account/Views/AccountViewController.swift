//
//  AccountViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 5.02.23.
//

import UIKit

class AccountViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: AccountPresenterProtocol?
    private var collectionView: UICollectionView?
    private var dataSource: CollectionViewDataSource?
    private let signOutButton = UIButton()
    private let activityIndicator = ActivityIndicator()
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
        addingSubviewsAndSettingConstraints()
    }
    
    //MARK: - View settings
    
    private func configureNavigationBar() {
        let leftTitle = UILabel()
        leftTitle.text = "Account"
        leftTitle.textColor = .white
        leftTitle.font = UIFont(name: "BadaBoomBB", size: 25)
        
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .white
        let image = UIImageView(image: UIImage(named: "BackButton")?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        backButton.setImage(image.image, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .primaryActionTriggered)
        
        let firstItem = UIBarButtonItem(customView: backButton)
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace,
                                                          target: nil, action: nil)
        fixedSpace.width = 10.0
        let secondItem = UIBarButtonItem(customView: leftTitle)
        navigationItem.leftBarButtonItems = [firstItem, fixedSpace, secondItem]
    }
    
    private func configureCollectionView() {
        view.backgroundColor = .white
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 130, height: 290)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10.0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        guard let collectionView else { return }
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        dataSource = CollectionViewDataSource(collectionView: collectionView, delegate: nil, client: presenter!.client)
        collectionView.delegate = self
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalToSuperview()
            make.height.equalTo(310)
        }
        
        activityIndicator.displayIndicator(view: collectionView)
        activityIndicator.startAnimating()
    }
    
    private func addingSubviewsAndSettingConstraints() {
        view.addSubview(signOutButton)
        
        signOutButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        signOutButton.layer.cornerRadius = 5
        signOutButton.backgroundColor = .black
        let signOutString = NSMutableAttributedString(string: "Sign Out", attributes: [
            .font: UIFont(name: "BadaBoomBB", size: 30) as Any
        ])
        signOutButton.setAttributedTitle(signOutString, for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped(_:)), for: .primaryActionTriggered)
        
        activityIndicator.displayIndicator(view: view)
        activityIndicator.startAnimating()
    }
    
    //MARK: - Targets
    
    @objc func backButtonTapped(_ sender: UIButton) {
        presenter?.backButtonTap()
    }
    
    @objc func signOutButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "Yes, sign out", style: .destructive) { [weak self] _ in
            self?.presenter?.signOut()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

//MARK: - extension AccountViewProtocol

extension AccountViewController: AccountViewProtocol {
    
    func startIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func signOutFailure(error: BaseError) {
        activityIndicator.stopAnimating()
        showErrorAlertController(viewController: self, error: error)
    }
    
    func loadCharactersSuccess() {
        guard let presenter else { return }
        activityIndicator.stopAnimating()
        dataSource?.bindData(presenter.characters)
    }
    
    func loadCharactersFailure(error: Error) {
        activityIndicator.stopAnimating()
        showErrorAlertController(viewController: self, error: error)
    }
}

extension AccountViewController: UICollectionViewDelegate {
    
}
