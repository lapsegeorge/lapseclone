//
//  RepositoryProtocol.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

protocol RepositoryProtocol {
    var configurator: ConfiguratorProtocol { get set }
    var baseURL: String { get }
}

extension RepositoryProtocol {
    var baseURL: String { configurator.configuration?.baseURL ?? "" }
}
