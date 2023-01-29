//
//  Validator.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 29.01.23.
//

import Foundation

class Validator {
    
    static func validateTextForMissingValue(text: String, message: String) throws -> String {
        guard text != "" else {
            throw BaseError(message: message)
        }
        return text
    }
}
