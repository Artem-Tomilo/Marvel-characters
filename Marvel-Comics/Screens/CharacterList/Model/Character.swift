//
//  Character.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation

class Character: Codable {
    let id : Int
    let name : String
    let description : String
    let image : Image
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image = "thumbnail"
    }
}
