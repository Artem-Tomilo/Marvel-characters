//
//  Character.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation

struct CharacterDataBase: Codable {
    let responseCode: Int
    let charactersData: Characters
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "code"
        case charactersData = "data"
    }
}
