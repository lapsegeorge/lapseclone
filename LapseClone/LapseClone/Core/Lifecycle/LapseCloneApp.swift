//
//  LapseCloneApp.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import SwiftUI

@main
struct LapseCloneApp: App {
    // MARK: - Properties
    
    @StateObject private var theme = Theme()
    
    // MARK: - UI Elements
    
    var body: some Scene {
        WindowGroup {
            TabContainerView()
                .environmentObject(theme)
        }
    }
}
