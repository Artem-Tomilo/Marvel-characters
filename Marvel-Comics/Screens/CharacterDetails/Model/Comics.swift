//
//  Comics.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import Foundation

struct Comics: Codable {
    let comics: [Comic]?
    
    enum CodingKeys: String, CodingKey{
        case comics = "results"
    } 
}
