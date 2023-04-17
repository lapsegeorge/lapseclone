//
//  RequestConstructor.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

typealias RequestModifier = ((URLRequest) -> URLRequest)

struct RequestConstructor {
    let endpoint: String
    let httpMethod: HTTPMethod
    var body: [String: Any]?
    var queryItems: [URLQueryItem]?
    let modifier: RequestModifier
}
