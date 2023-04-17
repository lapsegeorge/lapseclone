//
//  LapseListResponse.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

struct LapseListResponse: Decodable, Equatable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [User]?
}
