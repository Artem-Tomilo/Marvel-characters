//
//  NetworkServiceProtocol.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 20.01.23.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getCharacters(pageNumber: Int, completion: @escaping (Result<[Character]?, Error>) -> Void)
}
