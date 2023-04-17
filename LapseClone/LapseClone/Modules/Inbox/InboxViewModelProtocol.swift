//
//  InboxViewModelProtocol.swift
//  LapseClone
//
//  Created by George Leadbeater on 16/04/2023.
//

import Foundation

protocol InboxViewModelProtocol: ObservableObject {
    var lapseRepository: LapseRepositoryProtocol { get }
    var activities: [ActivitiesByDate] { get set }
    
    func fetchUsers() async
}
