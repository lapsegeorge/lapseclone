//
//  TestData.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

// MARK: - TestDataError

enum TestDataError: Error {
    case resourceDoesNotExist
}

// MARK: - TestData

class TestData {
    // MARK: - Enums
    
    enum FileName: String {
        case users
    }
    
    // MARK: - Public Methods
    
    static func loadJSON(with fileName: FileName) throws -> Data {
        guard let url = Bundle(for: self).url(forResource: fileName.rawValue, withExtension: "json") else {
            throw TestDataError.resourceDoesNotExist
        }
        return try Data(contentsOf: url)
    }
    
    static func modelFromJSON<T: Decodable>(with fileName: FileName) throws -> T {
        let data = try loadJSON(with: fileName)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
