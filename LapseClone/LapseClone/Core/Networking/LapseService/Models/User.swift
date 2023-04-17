//
//  User.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

struct User: Decodable, Equatable {
    let id: Int?
    let name: String?
    let profileImage, profileImageThumbnail: String?
}
