//
//  Configuration.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

struct Configuration: Decodable {
    let baseURL: String
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
    }
}
