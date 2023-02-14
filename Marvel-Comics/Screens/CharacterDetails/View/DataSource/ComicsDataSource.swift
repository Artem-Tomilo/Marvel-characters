//
//  ComicsDataSource.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 26.01.23.
//

import UIKit

class ComicsDataSource: NSObject {
    
    //MARK: - Properties
    
    private let tableView: UITableView
    private var character: Character?
    private var data = [Any]()
    
    //MARK: - Init
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        registerCells()
    }
    
    //MARK: - Functions
    
    private func registerCells() {
        tableView.register(CharacterDetailsHeaderTableViewCell.self,
                           forCellReuseIdentifier: CharacterDetailsHeaderTableViewCell.headerCellIdentifier)
        tableView.register(CharacterDescriptionTableViewCell.self,
                           forCellReuseIdentifier: CharacterDescriptionTableViewCell.descriptionCellIdentifier)
        tableView.register(CharacterComicsTableViewCell.self,
                           forCellReuseIdentifier: CharacterComicsTableViewCell.characterComicsCellIdentifier)
    }
    
    func bindData(_ data: [Any]) {
        self.data = data
    }
    
    func updateCharacter(_ character: Character) {
        self.character = character
        self.tableView.reloadData()
    }
}

//MARK: - extension UITableViewDelegate

extension ComicsDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 140
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 {
            return 60
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = HeaderView()
            view.bind("Character Bio")
            return view
        } else if section == 2 {
            let view = HeaderView()
            view.bind("Comics")
            return view
        }
        return nil
    }
}

//MARK: - extension UITableViewDataSource

extension ComicsDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let character else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CharacterDetailsHeaderTableViewCell.headerCellIdentifier,
                for: indexPath) as? CharacterDetailsHeaderTableViewCell else {
                return UITableViewCell()
            }
            cell.bind(character: character)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CharacterDescriptionTableViewCell.descriptionCellIdentifier,
                for: indexPath) as? CharacterDescriptionTableViewCell else {
                return UITableViewCell()
            }
            if character.description == "" {
                cell.bind("No description")
            } else {
                cell.bind(character.description)
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CharacterComicsTableViewCell.characterComicsCellIdentifier,
                for: indexPath) as? CharacterComicsTableViewCell else {
                return UITableViewCell()
            }
            cell.bind(comics: self.data as! [Comic])
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
