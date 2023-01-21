//
//  CharacterDetailsViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: CharacterDetailsPresenter?
    private let tableView = UITableView()
    private let activityIndicator = ActivityIndicator()
    static let headerCellIdentifier = "headerCell"
    static let descriptionCellIdentifier = "descriptionCell"
    static let characterComicsCellIdentifier = "chatacterComicsCell"
    static let comicCellIdentifier = "comicCell"
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    //MARK: - View settings
    
    private func configureNavigationBar(){
        let leftTitle = UILabel()
        leftTitle.text = "Character Details"
        leftTitle.textColor = .white
        leftTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
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
    
    private func configureTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterDetailsHeaderTableViewCell.self,
                           forCellReuseIdentifier: CharacterDetailsViewController.headerCellIdentifier)
        tableView.register(CharacterDescriptionTableViewCell.self,
                           forCellReuseIdentifier: CharacterDetailsViewController.descriptionCellIdentifier)
        tableView.register(CharacterComicsTableViewCell.self,
                           forCellReuseIdentifier: CharacterDetailsViewController.characterComicsCellIdentifier)
        
        activityIndicator.displayIndicator(view: tableView)
        activityIndicator.startAnimating()
        presenter?.getComics()
    }
    
    private func handleError(error: Error) {
        let baseError = error as! BaseError
        ErrorAlert.showAlertController(message: baseError.message, viewController: self)
    }
    
    //MARK: - Targets
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - extension CharacterDetailsViewProtocol

extension CharacterDetailsViewController: CharacterDetailsViewProtocol {
    func success() {
        self.activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        handleError(error: error)
        activityIndicator.stopAnimating()
    }
}
