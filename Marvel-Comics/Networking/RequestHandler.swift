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
    private let privateKey = ""
    
    func getCharacters(pageNumber: Int = 0) -> URLRequest {
        let endpoint = "/v1/public/characters"
        let url = baseURL + endpoint + buildQueryString(pageNumber: pageNumber, isCharacterList: true)
        let request = URLRequest(url: URL(string: url)!)
        return request
    }
    
    private func buildQueryString(pageNumber: Int = 0, isCharacterList: Bool = false) -> String {
        let timeStamp = Date().timeIntervalSince1970
        var queryString = "?ts=\(timeStamp)&apikey=\(publicKey)&hash=\(buildHashToken(timestamp: timeStamp))"
        if isCharacterList {
            var pageNumber = pageNumber
            pageNumber = limit * pageNumber
            queryString = queryString + "&limit=\(limit)&offset=\(pageNumber)"
        }
        return queryString
    }
    
    private func buildHashToken(timestamp: TimeInterval) -> String{
        let unhashedString = "\(timestamp)" + privateKey + publicKey
        return Hash.MD5(str: unhashedString)
    }
}
