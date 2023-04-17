//
//  LapseService.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

// MARK: - LapseServiceProtocol

protocol LapseServiceProtocol: APIServiceProtocol {
    func fetchUsers(with constructor: RequestConstructor) async throws -> LapseListResponse
}

// MARK: - LapseService

struct LapseService {
    // MARK: - APIServiceProtocol
    
    var session: URLSession = .shared
}

// MARK: - LapseServiceProtocol

extension LapseService: LapseServiceProtocol {
    func fetchUsers(with constructor: RequestConstructor) async throws -> LapseListResponse {
        try await task(with: constructor)
    }
}
