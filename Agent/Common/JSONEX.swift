//
//  JSONEX.swift
//  Agent
//
//  Created by Ibrahim on 06/07/2024.
//

import Foundation

extension JSONEncoder {
    static var map: JSONEncoder {
        let encoder: JSONEncoder = .init()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    static var user: JSONEncoder {
        let encoder: JSONEncoder = .init()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .useDefaultKeys
        return encoder
    }
}

extension JSONDecoder {
    static var map: JSONDecoder {
        let decoder: JSONDecoder = .init()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    static var user: JSONDecoder {
        let decoder: JSONDecoder = .init()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }
}
