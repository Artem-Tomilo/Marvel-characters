//
//  Characters.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation

struct Characters: Codable {
    let limit: Int
    let numberOfCharacters: Int
    let characters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case numberOfCharacters = "count"
        case characters = "results"
        case limit
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        numberOfCharacters = try values.decode(Int.self, forKey: .numberOfCharacters)
        limit = try values.decode(Int.self, forKey: .limit)
        characters = try values.decode([Character].self, forKey: .characters)
    }
}
