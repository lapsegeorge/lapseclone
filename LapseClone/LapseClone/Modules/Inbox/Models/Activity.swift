//
//  Activity.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

struct Activity {
    var id = UUID()
    var profileImage: String
    let username: String
    let type: ActivityType
    let timestamp: String
    var message: String?
    var image: String?
}

// MARK: - Mock

// swiftlint:disable line_length
extension Activity {
    static let mockReaction = Activity(profileImage: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/thomas_pesquet_thumbnail_20220911033657.jpeg",
                                       username: "georgehl",
                                       type: .reaction,
                                       timestamp: "1 wk ago",
                                       message: "🧨",
                                       image: "https://news.artnet.com/app/news-upload/2022/09/IMG_0570-256x256.jpg")
    static let mockNewFriend = Activity(profileImage: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/thomas_pesquet_thumbnail_20220911033657.jpeg",
                                        username: "georgehl",
                                        type: .newFriend,
                                        timestamp: "2 wk ago")
}
