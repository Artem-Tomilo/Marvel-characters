//
//  NetworkServiceProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func loadCharacters(pageNumber: Int, completion: @escaping (Result<[Character], BaseError>) -> Void)
    func loadComics(id: Int, completion: @escaping (Result<[Comic], BaseError>) -> Void)
}
