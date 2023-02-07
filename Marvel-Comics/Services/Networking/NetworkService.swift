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
    
    func loadCharacters(pageNumber: Int, completion: @escaping (Result<[Character], BaseError>) -> Void) {
        let endpoint = "/v1/public/characters"
        let stringUrl = baseURL + endpoint + buildQueryString(pageNumber: pageNumber, isCharacterList: true)
        
        AF.request(stringUrl).responseDecodable(of: CharacterDataBase.self) { response in
            do {
                let dataBase = try response.result.get()
                print(dataBase.responseCode)
                let characters = dataBase.charactersData.characters
                completion(.success(characters))
            } catch {
                completion(.failure(BaseError(message: "An unexpected error occurred. Try again")))
            }
        }
    }
    
    func loadComics(id: Int, completion: @escaping (Result<[Comic], BaseError>) -> Void) {
        let endpoint = "/v1/public/characters/\(id)/comics"
        let stringUrl  = baseURL + endpoint + buildQueryString()
        
        AF.request(stringUrl).responseDecodable(of: ComicDataBase.self) { response in
            do {
                let dataBase = try response.result.get()
                print(dataBase.responseCode)
                let comics = dataBase.comicsData.comics
                guard let comics else { return }
                completion(.success(comics))
            } catch {
                completion(.failure(BaseError(message: "An unexpected error occurred. Try again")))
            }
        }
    }
    
    func loadCharacter(with id: Int, _ completion: @escaping (Result<Character, BaseError>) -> Void) {
        let endpoint = "/v1/public/characters/\(id)"
        let stringUrl = baseURL + endpoint + buildQueryString()
        
        AF.request(stringUrl).responseDecodable(of: CharacterDataBase.self) { response in
            do {
                let dataBase = try response.result.get()
                print(dataBase.responseCode)
                guard let character = dataBase.charactersData.characters.first(where: {$0.id == id}) else { return }
                completion(.success(character))
            } catch {
                completion(.failure(BaseError(message: "An unexpected error occurred. Try again")))
            }
        }
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
    
    private func buildHashToken(timestamp: TimeInterval) -> String {
        let unhashedString = "\(timestamp)" + privateKey + publicKey
        return Hash.MD5(str: unhashedString)
    }
}
