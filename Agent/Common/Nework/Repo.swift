//
//  Repo.swift
//  Agent
//
//  Created by ibrahim on 26/03/2023.
//

import Foundation

protocol Repo: AnyObject, Handler { }

extension Repo {
//    static func handle<D: Decodable>(response: Result<Response<D>, Error>) -> Result<D?, Error> {
    static func handle<D: Decodable>(response: Result<D, Error>) -> Result<D?, Error> {
        switch response {
            case .failure(let error):
                return .failure(error)
            case .success(let result):
                let response = result
                return .success(response)
        }
    }
}
