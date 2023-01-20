//
//  BaseError.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import Foundation

struct BaseError: Error {
    var message: String
    
    init(message: String) {
        self.message = message
    }
}
