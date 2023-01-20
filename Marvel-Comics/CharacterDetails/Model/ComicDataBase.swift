//
//  ComicDataBase.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import Foundation

struct ComicDataBase: Codable {
    let responseCode: Int
    let comicsData: Comics
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "code"
        case comicsData = "data"
    }
}
