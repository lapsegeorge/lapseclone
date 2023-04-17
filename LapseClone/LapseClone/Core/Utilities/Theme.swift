//
//  Theme.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

final class Theme: ObservableObject {
    // MARK: - Properties
    
    @Published var spacing = Spacing()
    
    // MARK: - Spacing
    
    struct Spacing {
        let extraSmall: CGFloat = 5
        let small: CGFloat = 10
        let mediumSmall: CGFloat = 15
        let medium: CGFloat = 20
        let mediumLarge: CGFloat = 25
        let large: CGFloat = 30
        let extraLarge: CGFloat = 40
    }
}
