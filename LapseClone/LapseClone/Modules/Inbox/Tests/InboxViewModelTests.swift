//
//  InboxViewModelTests.swift
//  LapseClone
//
//  Created by George Leadbeater on 17/04/2023.
//

@testable import LapseClone
import XCTest

@MainActor 
class InboxViewModelTests: XCTestCase {
    // MARK: - Properties
    
    var viewModel: InboxViewModel!
    var lapseRepository: MockLapseRepository!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        lapseRepository = MockLapseRepository()
        viewModel = InboxViewModel(lapseRepository: lapseRepository)
    }
    
    // MARK: - Test Methods
    
    func testWhenFetchUsers_ThenCallsRepository() async throws {
        await viewModel.fetchUsers()
        
        XCTAssertTrue(lapseRepository.fetchUsersCalled)
    }
    
    func testWhenFetchUsers_ThenUpdatesActivities() async throws {
        await viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.activities.count, Constants.numberOfActivityDateSections)
        let weekActivities = viewModel.activities.first
        let monthActivities = viewModel.activities.last
        XCTAssertEqual(weekActivities?.activities.count, InboxViewModel.Constants.mockWeekActivities.count)
        XCTAssertEqual(monthActivities?.activities.count, InboxViewModel.Constants.mockMonthActivities.count)
        XCTAssertEqual(weekActivities?.title, L10n.dThisWeek)
        XCTAssertEqual(monthActivities?.title, L10n.dThisMonth)
    }
}

// MARK: - Constants

extension InboxViewModelTests {
    private struct Constants {
        static let numberOfActivityDateSections: Int = 2
    }
}
