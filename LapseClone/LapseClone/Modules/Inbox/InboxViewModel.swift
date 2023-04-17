//
//  InboxViewModel.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

// MARK: - ActivitiesByDate

struct ActivitiesByDate: Identifiable {
    var id = UUID()
    var activities: [Activity]
    var title: String
}

// MARK: - InboxViewModel

@MainActor
class InboxViewModel: ObservableObject {
    // MARK: - InboxViewModelProtocol
    
    var lapseRepository: LapseRepositoryProtocol
    @Published var activities: [ActivitiesByDate] = []
    
    // MARK: - Lifecycle
    
    init(lapseRepository: LapseRepositoryProtocol = LapseRepository()) {
        self.lapseRepository = lapseRepository
    }
    
    // MARK: - Private Methods
    
    private func prepareData(with users: LapseListResponse) {
        let profilePhotos = Set<String>(
            users.results?
                .compactMap { $0.profileImageThumbnail } ?? []
        )
        
        let weekProfilePhotos = Set<String>(profilePhotos.prefix(Constants.mockWeekActivities.count))
        let monthProfilePhotos = Set<String>(profilePhotos.prefix(Constants.mockMonthActivities.count))
        
        var mockWeekActivities = Constants.mockWeekActivities
        let weekActivities = processActivities(&mockWeekActivities, photos: weekProfilePhotos)
        
        var mockMonthActivities = Constants.mockMonthActivities
        let monthActivities = processActivities(&mockMonthActivities, photos: monthProfilePhotos)
        
        activities = [
            ActivitiesByDate(activities: weekActivities, title: L10n.dThisWeek),
            ActivitiesByDate(activities: monthActivities, title: L10n.dThisMonth)
        ]
    }
    
    private func processActivities(_ activities: inout [Activity], photos: Set<String>) -> [Activity] {
        activities.enumerated().forEach {
            activities[$0.offset].profileImage = photos.randomElement() ?? ""
        }
        return activities
    }
}

// MARK: - InboxViewModelProtocol

extension InboxViewModel: InboxViewModelProtocol {
    func fetchUsers() async {
        do {
            let response = try await lapseRepository.fetchUsers()
            prepareData(with: response)
        } catch {
            print(error)
        }
    }
}

// MARK: - Constants

// swiftlint:disable line_length
extension InboxViewModel {
    struct Constants {
        static let mockWeekActivities: [Activity] = [
            .init(profileImage: "",
                  username: "michael",
                  type: .reaction,
                  timestamp: "19 hr ago",
                  message: "🤩",
                  image: "https://images-stylist.s3-eu-west-1.amazonaws.com/app/uploads/2023/04/14113141/yosemite-article-image-2-256x256.jpg"),
            .init(profileImage: "",
                  username: "michael",
                  type: .reaction,
                  timestamp: "19 hr ago",
                  message: "🧨",
                  image: "https://res.cloudinary.com/travelmassive/image/upload/c_fill,g_auto,h_256,w_256/travel_massive/production/public_images/user_profile_pictures/atiw8tb3hnugwgcfwroc.webp"),
            .init(profileImage: "",
                  username: "morgan",
                  type: .newFriend,
                  timestamp: "5 days ago")
        ]
        static let mockMonthActivities: [Activity] = [
            .init(profileImage: "",
                  username: "jennyh",
                  type: .reaction,
                  timestamp: "2 wks ago",
                  message: "👁️",
                  image: "https://www.gigasavvy.com/wp/wp-content/uploads/2019/04/GettyImages-485022738-1-1.jpg"),
            .init(profileImage: "",
                  username: "james",
                  type: .newFriend,
                  timestamp: "2 wks ago"),
            .init(profileImage: "",
                  username: "ashley",
                  type: .newFriend,
                  timestamp: "2 wks ago"),
            .init(profileImage: "",
                  username: "martin",
                  type: .newFriend,
                  timestamp: "2 wks ago")
        ]
    }
}
