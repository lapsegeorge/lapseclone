//
//  InboxSectionHeader.swift
//  LapseClone
//
//  Created by George Leadbeater on 17/04/2023.
//

import SwiftUI

struct InboxSectionHeader: View {
    var title: String
    
    // MARK: - UI Elements
    
    var body: some View {
        Text(title)
            .font(.body)
            .padding(.leading)
            .foregroundColor(.white.opacity(Constants.fontOpacity))
            .textCase(.none)
    }
}

// MARK: - PreviewProvider

struct InboxSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        InboxSectionHeader(title: L10n.dThisWeek)
            .background(Asset.Colors.lapseGrayDark.swiftUIColor)
    }
}

// MARK: - Constants

extension InboxSectionHeader {
    private struct Constants {
        static let fontOpacity: Double = 0.8
    }
}
