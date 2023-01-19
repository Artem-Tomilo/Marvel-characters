//
//  Character.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation

struct Character: Codable {
    let id : Int?
    let name : String?
    let description : String?
    let modified : String?
    let thumbnail : Thumbnail?
    let resourceURI : String?
    //    let comics : CharacterComics?
}
