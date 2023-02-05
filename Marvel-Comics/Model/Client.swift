//
//  Person.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 5.02.23.
//

import Foundation

struct Client: Codable {
    var email: String
    var id: String
    var favoriteCharactersID: [String]?
}
