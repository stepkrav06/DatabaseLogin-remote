//
//  EventTasks.swift
//
//  Used to transfer a list of tasks and events through views (for assigning tasks)
//
//

import Foundation


class EventTasks: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var users: [User] = []
    @Published var usersId: [String] = []
}
