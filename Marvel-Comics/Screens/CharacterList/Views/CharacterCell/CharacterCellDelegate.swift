//
//  CharacterCellDelegate.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 6.02.23.
//

import Foundation

protocol CharacterCellDelegate: AnyObject {
    func likeButtonTappedToSave(_ character: Character)
    func likeButtonTappedToDelete(_ character: Character)
}
