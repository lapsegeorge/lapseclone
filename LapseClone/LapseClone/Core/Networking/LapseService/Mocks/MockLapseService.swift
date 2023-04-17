//
//  MockLapseService.swift
//  LapseCloneTests
//
//  Created by George Leadbeater on 16/04/2023.
//

@testable import LapseClone
import XCTest

class MockLapseService {
    // MARK: - LapseServiceProtocol
    
    var session: URLSession = .shared
    
    // MARK: - Test Properties
    
    var fetchUsersCalled = false
    var fetchUsersConstructor: RequestConstructor?
}

// MARK: - LapseServiceProtocol

extension MockLapseService: LapseServiceProtocol {
    func fetchUsers(with constructor: RequestConstructor) async throws -> LapseListResponse {
        fetchUsersCalled = true
        fetchUsersConstructor = constructor
        
        return try TestData.modelFromJSON(with: .users)
    }
}
