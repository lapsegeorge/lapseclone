//
//  MockInboxViewModel.swift
//  LapseClone
//
//  Created by George Leadbeater on 17/04/2023.
//

import Foundation

class MockInboxViewModel {
    var lapseRepository: LapseRepositoryProtocol = MockLapseRepository()
    var activities: [ActivitiesByDate] = [
        ActivitiesByDate(activities: [Activity.mockReaction, Activity.mockNewFriend], title: L10n.dThisWeek),
        ActivitiesByDate(activities: [Activity.mockReaction, Activity.mockNewFriend], title: L10n.dThisMonth)
    ]
}

// MARK: - InboxViewModelProtocol

extension MockInboxViewModel: InboxViewModelProtocol {
    func fetchUsers() async {}
}
