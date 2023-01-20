//
//  CharacterDetailsViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var presenter: CharacterDetailsPresenter?
    private let tableView = UITableView()
    private let activityIndicator = ActivityIndicator()
    static let detailCellIdentifier = "detailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
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
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: CharacterDetailsViewController.detailCellIdentifier)
        
        activityIndicator.displayIndicator(view: tableView)
        activityIndicator.startAnimating()
        presenter?.getComics()
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension CharacterDetailsViewController: UITableViewDelegate {
    
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.comics.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsViewController.detailCellIdentifier,
                                                 for: indexPath)
        cell.backgroundColor = .blue
        self.activityIndicator.stopAnimating()
        return cell
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
