//
//  MockLapseRepository.swift
//  LapseCloneTests
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

class MockLapseRepository {
    // MARK: - RepositoryProtocol
    
    lazy var configurator: ConfiguratorProtocol = Configurator.shared
    
    // MARK: - Test Properties
    
    var fetchUsersCalled = false
}

// MARK: - LapseRepositoryProtocol

extension MockLapseRepository: LapseRepositoryProtocol {
    func fetchUsers() async throws -> LapseListResponse {
        fetchUsersCalled = true
        return try TestData.modelFromJSON(with: .users)
    }
}
