//
//  Configurator.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

// MARK: - ConfiguratorProtocol

protocol ConfiguratorProtocol {
    var configuration: Configuration? { get }
}

// MARK: - Configurator

class Configurator: ConfiguratorProtocol {
    // MARK: - Properties
    
    static let shared = Configurator()
    var configuration: Configuration?
    
    // MARK: - Lifecycle
    
    private init() {
        guard let url = Bundle.main.url(forResource: Constants.fileName, withExtension: Constants.fileExtension) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            configuration = try PropertyListDecoder().decode(Configuration.self, from: data)
        } catch {
            print(error)
        }
    }
}

// MARK: - Constants

extension Configurator {
    private struct Constants {
        static let fileName: String = "Configurations"
        static let fileExtension: String = "plist"
    }
}
