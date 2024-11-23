//
//  Handler.swift
//  Agent
//
//  Created by ibrahim on 26/03/2023.
//

import Foundation

typealias HandlerCombo = () -> Void

protocol Handler { }

extension Handler {
    static func handle(server error: ErrorModel?) -> AppError {
        var message = error?.message?.replacingOccurrences(of: "Key", with: "")
        if message?.isEmpty == .true {
            message = localize.unknownError()
            
        }
        if message == "session ended" {
            Observer.fire(observer: .logout)
        }
        let appError = AppError(message: message)
        return appError
    }
    
    static func handleError(_ error: Data?) -> AppError {
        
        let responseObj = try? JSONSerialization.jsonObject(with: error ?? .init(), options: [])
        if let response = responseObj as? [String: Any] {
            print(response)
            var message: String = ""
            if let errors = response["errors"] as? [String:Any] {
                for val in errors.values {
                    message = "\(message) \(val)"
                }
            }
            
            if let errors = response["data"] as? [String:Any] {
                for val in errors.values {
                    if let value = val as? [String] {
                        message = "\(message) \(value.joined(separator: "\n"))"
                    }else {
                        message = "\(message) \(val)"
                    }
                }
            }
            
            let appError = AppError(message: message)
            return appError
        }else {
            let appError = AppError(message: localize.unknownError())
            return appError
        }
        
    }
}
