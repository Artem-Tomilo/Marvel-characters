//
//  TableView.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 21.01.23.
//

import UIKit

//MARK: - extension UITableView

extension CharacterDetailsViewController: UITableViewDelegate {
    
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

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CharacterDetailsViewController.headerCellIdentifier,
                for: indexPath) as? CharacterDetailsHeaderTableViewCell else {
                return UITableViewCell()
            }
            guard let character = presenter?.character else { return cell }
            cell.bind(character: character)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CharacterDetailsViewController.descriptionCellIdentifier,
                for: indexPath) as? CharacterDescriptionTableViewCell else {
                return UITableViewCell()
            }
            guard let character = presenter?.character else { return cell }
            if character.description == "" {
                cell.bind("No description")
            } else {
                cell.bind(character.description)
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CharacterDetailsViewController.characterComicsCellIdentifier,
                for: indexPath) as? CharacterComicsTableViewCell else {
                return UITableViewCell()
            }
            guard let comics = presenter?.comics else { return cell }
            DispatchQueue.main.async {
                cell.bind(comics: comics)
            }
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
