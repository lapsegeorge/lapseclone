//
//  LapseRepositoryTests.swift
//  LapseCloneTests
//
//  Created by George Leadbeater on 17/04/2023.
//

@testable import LapseClone
import XCTest

class LapseRepositoryTests: XCTestCase {
    // MARK: - Properties
    
    var lapseRepository: LapseRepository!
    var lapseService: MockLapseService!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        lapseRepository = LapseRepository()
        lapseService = MockLapseService()
        lapseRepository.service = lapseService
    }
    
    // MARK: - Test Methods
    
    func testWhenFetchUsers_ThenRequestConstructedCorrectly() async throws {
        let endpoint = Constants.baseURL + LapseRepository.Path.users.rawValue
        let mockRequestConstructor = RequestConstructor(endpoint: endpoint,
                                                        httpMethod: .GET,
                                                        queryItems: [URLQueryItem(name: Constants.queryItems.name,
                                                                                  value: Constants.queryItems.value)],
                                                        modifier: {
            $0.acceptingJSON()
        })
        
        _ = try await lapseRepository.fetchUsers()
        
        XCTAssertTrue(lapseService.fetchUsersCalled)
        XCTAssertEqual(lapseService.fetchUsersConstructor?.endpoint, mockRequestConstructor.endpoint)
        XCTAssertEqual(lapseService.fetchUsersConstructor?.httpMethod, mockRequestConstructor.httpMethod)
        XCTAssertEqual(lapseService.fetchUsersConstructor?.queryItems, mockRequestConstructor.queryItems)
    }
}

// MARK: - Constants

extension LapseRepositoryTests {
    private struct Constants {
        static let baseURL = Configurator.shared.configuration?.baseURL ?? ""
        static let queryItems: (name: String, value: String) = ("limit", "10")
    }
}
