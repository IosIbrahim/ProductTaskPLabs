//
//  Respnse.swift
//  Agent
//
//  Created by ibrahim on 26/03/2023.
//

import Foundation


internal struct AppError: LocalizedError {
    private var message: String
    
    init(message: String?) {
        self.message = message ?? ""
    }

    var localizedDescription: String { errorDescription ?? "" }

    var errorDescription: String? { message }

    var localizedMessage: String { message }
}

extension Error {
    func asAppError() -> AppError? {
        if self.localizedDescription.contains("server") {
            return AppError(message: localize.unread())
        }else if self.localizedDescription.contains("timed out") {
            return AppError(message: localize.unread())
        }else {
            return AppError(message: self.localizedDescription)
        }
    }
}

struct Response<Value: Codable>: Codable {
    let status: Bool?
    var code: Int?
    let error: ErrorModel?
    let data: Value?
    var message: String?

    private enum CodingKeys: String, CodingKey {
        case data = "data"
        case error = "errors"
        case code = "code"
        case status = "isclean"
        case message
    }
}

struct ErrorModel: Codable {
    var message: String?
   
    private enum CodingKeys: String, CodingKey {
        case message
    }
}
