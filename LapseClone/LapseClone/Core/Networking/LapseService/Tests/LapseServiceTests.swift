//
//  LapseServiceTests.swift
//  LapseCloneTests
//
//  Created by George Leadbeater on 16/04/2023.
//

@testable import LapseClone
import XCTest

class LapseServiceTests: XCTestCase {
    // MARK: - Properties
    
    var lapseService: LapseService!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        lapseService = LapseService()
        lapseService.session = Constants.urlSession
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = nil
    }
    
    // MARK: - Test Methods
    
    func testWhenFetchUsers_ThenResponseIsEqual() async throws {
        let mockJSONData = try XCTUnwrap(TestData.loadJSON(with: .users))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let mockResponse = try decoder.decode(LapseListResponse.self, from: mockJSONData)
        
        MockURLProtocol.requestHandler = { _ in
            let response = try XCTUnwrap(HTTPURLResponse())
            return (response, mockJSONData)
        }
        
        let response = try await lapseService.fetchUsers(with: Constants.mockRequestConstructor)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response, mockResponse)
    }
}

// MARK: - Constants

extension LapseServiceTests {
    private struct Constants {
        static let urlSession: URLSession = {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [MockURLProtocol.self]
            return URLSession(configuration: configuration)
        }()
        static let mockRequestConstructor = RequestConstructor(endpoint: "",
                                                               httpMethod: .GET,
                                                               modifier: { $0 })
    }
}
