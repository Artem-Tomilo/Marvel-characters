//
//  CharacterDetailsViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: CharacterDetailsPresenterProtocol?
    private let tableView = UITableView()
    private let activityIndicator = ActivityIndicator()
    private var dataSource: ComicsDataSource?
    
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
    
    private func configureTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dataSource = ComicsDataSource(tableView: tableView)
        
        activityIndicator.displayIndicator(view: tableView)
        activityIndicator.startAnimating()
        presenter?.loadComics()
    }
    
    private func handleError(error: Error) {
        let baseError = error as! BaseError
        showAlertController(message: baseError.message, viewController: self)
    }
    
    //MARK: - Targets
    
    @objc func backButtonTapped(_ sender: UIButton) {
        presenter?.backButtonTap()
    }
}

//MARK: - extension CharacterDetailsViewProtocol

extension CharacterDetailsViewController: CharacterDetailsViewProtocol {
    func loadComicsSuccess() {
        self.activityIndicator.stopAnimating()
        guard let presenter,
              let comics = presenter.comics,
              let character = presenter.character else { return }
        dataSource?.updateData(with: comics)
        dataSource?.updateCharacter(character)
    }
    
    func loadComicsFailure(error: Error) {
        handleError(error: error)
        activityIndicator.stopAnimating()
    }
}
