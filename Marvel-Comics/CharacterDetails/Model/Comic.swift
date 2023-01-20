//
//  Comic.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import Foundation

struct Comic: Codable {
    let id: Int
    let title: String
    let image: Image
    
    enum CodingKeys: String, CodingKey{
        case image = "thumbnail"
        case id
        case title
    }
}
