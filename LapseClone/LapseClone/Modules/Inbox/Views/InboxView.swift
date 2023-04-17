//
//  InboxView.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import SwiftUI

struct InboxView<Model>: View where Model: InboxViewModelProtocol {
    // MARK: - Properties
    
    @EnvironmentObject private var theme: Theme
    @ObservedObject var viewModel: Model
    @State private var isDisplayingSheet = false
    @State private var hasLoaded = false
    
    // MARK: - UI Elements
    
    var listView: some View {
        List {
            ForEach(viewModel.activities) { activityByDate in
                Section {
                    ForEach(activityByDate.activities, id: \.id) { activity in
                        InboxRow(activity: activity)
                            .listRowBackground(Color.clear)
                    }
                } header: {
                    InboxSectionHeader(title: activityByDate.title)
                }
                .listRowSeparator(.hidden)
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.grouped)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Asset.Colors.lapseGrayDark.swiftUIColor
                    .ignoresSafeArea()
                
                listView
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isDisplayingSheet.toggle()
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .tint(.white)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(L10n.dAllActivity)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isDisplayingSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .tint(.white)
                    }
                }
            }
            .sheet(isPresented: $isDisplayingSheet) {
                ThankYouView()
            }
        }
        .onAppear {
            guard hasLoaded == false else { return }
            hasLoaded = true
            Task {
                await viewModel.fetchUsers()
            }
        }
    }
}

// MARK: - PreviewProvider

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(viewModel: MockInboxViewModel())
            .environmentObject(Theme())
    }
}
