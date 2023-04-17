//
//  APIServiceProtocol.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

protocol APIServiceProtocol {
    var session: URLSession { get }
    
    func task<T: Decodable>(with constructor: RequestConstructor) async throws -> T
}

extension APIServiceProtocol {
    func task<T: Decodable>(with constructor: RequestConstructor) async throws -> T {
        let request = try build(with: constructor)
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.nonHTTPResponse
        }
        
        let successfulStatusCodes = (200...299)
        guard successfulStatusCodes.contains(httpResponse.statusCode) else {
            throw APIError.unexpectedStatusCode(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.unableToDeserialize(description: error.localizedDescription)
        }
    }
    
    private func build(with constructor: RequestConstructor) throws -> URLRequest {
        var urlComponents = URLComponents(string: constructor.endpoint)
        
        if let queryItems = constructor.queryItems {
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else { throw APIError.unableToSerialize }
        
        var request = URLRequest(url: url)
        request.httpMethod = constructor.httpMethod.rawValue
        
        do {
            if let body = constructor.body { request.httpBody = try JSONSerialization.data(withJSONObject: body) }
        } catch {
            throw APIError.unableToSerialize
        }
        
        return request
    }
}
