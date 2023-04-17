//
//  LapseRepository.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

// MARK: - LapseRepositoryProtocol

protocol LapseRepositoryProtocol: RepositoryProtocol {
    func fetchUsers() async throws -> LapseListResponse
}

// MARK: - LapseRepository

struct LapseRepository {
    // MARK: - RepositoryProtocol
    
    var service: LapseServiceProtocol = LapseService()
    var configurator: ConfiguratorProtocol = Configurator.shared
    
    // MARK: - Enums
    
    enum Path: String {
        case users = "/2.2.0/astronaut/"
    }
}

// MARK: - LapseRepositoryProtocol

extension LapseRepository: LapseRepositoryProtocol {
    func fetchUsers() async throws -> LapseListResponse {
        let endpoint = baseURL + Path.users.rawValue
        let queryItems = [URLQueryItem(name: Constants.queryItems.name, value: Constants.queryItems.value)]
        
        let requestConstructor = RequestConstructor(endpoint: endpoint,
                                                    httpMethod: .GET,
                                                    queryItems: queryItems,
                                                    modifier: {
            $0.acceptingJSON()
        })
        
        return try await service.fetchUsers(with: requestConstructor)
    }
}

// MARK: - Constants

extension LapseRepository {
    private struct Constants {
        static let queryItems: (name: String, value: String) = ("limit", "10")
    }
}
