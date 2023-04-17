//
//  CustomTabView.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import SwiftUI

struct TabContainerView: View {
    // MARK: - Properties
    
    @EnvironmentObject private var theme: Theme
    @State private var inboxViewModel = InboxViewModel()
    @State private var selectedTab = Constants.inboxTab
    
    // MARK: - Lifecycle
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = Asset.Colors.lapseGrayLight.color
    }
    
    // MARK: - UI Elements
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                ThankYouView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text(L10n.aJournal)
                    }.tag(Constants.journalTab)
                
                ThankYouView()
                    .tabItem {
                        Image(systemName: "square.grid.2x2.fill")
                        Text(L10n.aMemories)
                    }.tag(Constants.memoriesTab)
                
                ThankYouView()
                    .tabItem {
                        EmptyView()
                    }.tag(Constants.cameraTab)
                
                InboxView(viewModel: inboxViewModel)
                    .tabItem {
                        Image(systemName: "heart")
                        Text(L10n.aInbox)
                    }.tag(Constants.inboxTab)
                
                ThankYouView()
                    .tabItem {
                        Image(asset: Asset.Images.georgeLeadbeater)
                        Text(L10n.aMe)
                    }.tag(Constants.meTab)
            }.accentColor(.white)
            
            HStack {
                Button(action: { selectedTab = Constants.cameraTab }, label: {
                    Circle()
                        .fill(selectedTab == Constants.cameraTab ? Color.white : Asset.Colors.lapseGrayLight.swiftUIColor)
                        .overlay(Circle().stroke(Color.clear, lineWidth: theme.spacing.extraSmall))
                        .padding(theme.spacing.extraSmall)
                        .overlay(Circle().stroke(selectedTab == Constants.cameraTab ? Color.white : Asset.Colors.lapseGrayLight.swiftUIColor,
                                                 lineWidth: Constants.outerCircleWidth))
                        .frame(width: Constants.circleDimensions, height: Constants.circleDimensions)
                })
                .accessibilityLabel(L10n.accessibilityCamera)
            }
        }
    }
}

// MARK: - PreviewProvider

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
            .environmentObject(Theme())
    }
}

// MARK: - Constants

extension TabContainerView {
    private struct Constants {
        static let journalTab: Int = 0
        static let memoriesTab: Int = 1
        static let cameraTab: Int = 2
        static let inboxTab: Int = 3
        static let meTab: Int = 4
        static let outerCircleWidth: Double = 2
        static let circleDimensions: Double = 55
    }
}
