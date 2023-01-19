//
//  RequestHandler.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation

class RequestHandler {
    
    private let limit = 10
    private let baseURL = "https://gateway.marvel.com"
    private let publicKey = "8bd050fc93e12270fe8f7e86de47238a"
    private let privateKey = "87ac8756494f4167c6a4a623bf7de9c70f50bcc2"
    
    func getCharacters(pageNumber: Int) -> String {
        let endpoint = "/v1/public/characters"
        let stringUrl = baseURL + endpoint + buildQueryString(pageNumber: pageNumber, isCharacterList: true)
        return stringUrl
    }
    
    private func buildQueryString(pageNumber: Int, isCharacterList: Bool = false) -> String {
        let timeStamp = Date().timeIntervalSince1970
        var queryString = "?ts=\(timeStamp)&apikey=\(publicKey)&hash=\(buildHashToken(timestamp: timeStamp))"
        if isCharacterList {
            var pageNumber = pageNumber
            pageNumber = limit * pageNumber
            queryString = queryString + "&limit=\(limit)&offset=\(pageNumber)"
        }
        return queryString
    }
    
    private func buildHashToken(timestamp: TimeInterval) -> String {
        let unhashedString = "\(timestamp)" + privateKey + publicKey
        return Hash.MD5(str: unhashedString)
    }
}
