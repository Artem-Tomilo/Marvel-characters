//
//  Thumbnail.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation

struct CharacterImage : Codable {
    let path : String
    let fileExtension : String
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
