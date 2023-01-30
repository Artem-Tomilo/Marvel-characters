//
//  CharacterListViewProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 22.01.23.
//

import Foundation

protocol CharacterListViewProtocol: AnyObject {
    func loadCharactersSuccess()
    func loadCharactersFailure(error: Error)
}
