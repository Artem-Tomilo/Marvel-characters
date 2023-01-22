//
//  Character.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation

struct Character: Codable {
    let id : Int
    let name : String
    let description : String
    let image : Image
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image = "thumbnail"
    }
}
