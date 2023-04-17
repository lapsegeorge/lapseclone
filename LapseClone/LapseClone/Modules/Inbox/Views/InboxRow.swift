//
//  InboxRow.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import SwiftUI

struct InboxRow: View {
    // MARK: - Properties
    
    @EnvironmentObject var theme: Theme
    let activity: Activity
    
    // MARK: - Computed Properties
    
    private var username: AttributedString {
        var username = AttributedString(activity.username)
        username.font = .body.bold()
        username.foregroundColor = .white
        return username
    }
    
    private var description: AttributedString {
        var description = AttributedString(descriptionString)
        description.font = .body
        description.foregroundColor = Asset.Colors.lapseGrayLight.swiftUIColor
        return description
    }
    
    private var descriptionString: String {
        switch activity.type {
        case .newFriend: return L10n.dActivityNewFriend
        case .reaction: return L10n.dActivityReaction(activity.message ?? "")
        }
    }
    
    // MARK: - UI Elements
    
    var body: some View {
        HStack(spacing: theme.spacing.small) {
            AsyncImage(url: URL(string: activity.profileImage)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: Constants.imageDimensions, height: Constants.imageDimensions)
            .background(Asset.Colors.lapseGrayLight.swiftUIColor)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: Constants.stackSpacing) {
                Text(username + description)
                Text(activity.timestamp)
                    .font(.footnote)
                    .foregroundColor(Asset.Colors.lapseGrayLight.swiftUIColor)
            }
            
            if let imageURL = activity.image {
                Spacer()
                
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: Constants.imageDimensions, height: Constants.imageDimensions)
                .cornerRadius(Constants.cornerRadius)
            }
        }
    }
}

// MARK: - PreviewProvider

struct InboxRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            InboxRow(activity: Activity.mockReaction)
                .background(Asset.Colors.lapseGrayDark.swiftUIColor).environmentObject(Theme())
            
            InboxRow(activity: Activity.mockNewFriend)
                .background(Asset.Colors.lapseGrayDark.swiftUIColor)
                .environmentObject(Theme())
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Constants

extension InboxRow {
    private struct Constants {
        static let stackSpacing: Double = 3
        static let cornerRadius: Double = 8
        static let imageDimensions: Double = 40
    }
}
