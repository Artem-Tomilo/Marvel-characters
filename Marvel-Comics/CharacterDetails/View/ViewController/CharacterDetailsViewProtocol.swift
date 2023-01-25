//
//  CharacterDetailsViewProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 22.01.23.
//

import Foundation

protocol CharacterDetailsViewProtocol: AnyObject {
    func loadComicsSuccess()
    func loadComicsFailure(error: Error)
}
