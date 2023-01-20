//
//  NetworkService.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation
import Alamofire

class NetworkService: NetworkServiceProtocol {
    
    private let limit = 10
    private let baseURL = "https://gateway.marvel.com"
    private let publicKey = "8bd050fc93e12270fe8f7e86de47238a"
    private let privateKey = ""
    
    func getCharacters(pageNumber: Int, completion: @escaping (Result<[Character]?, Error>) -> Void) {
        let endpoint = "/v1/public/characters"
        let stringUrl = baseURL + endpoint + buildQueryString(pageNumber: pageNumber, isCharacterList: true)
        
        guard let url = URL(string: stringUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)
            
            guard let data else { return }
            
            do {
                let result = try JSONDecoder().decode(CharacterDataBase.self, from: data)
                let characters = result.charactersData.characters
                completion(.success(characters))
            } catch {
                completion(.failure(error))
            }
        }.resume()
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
