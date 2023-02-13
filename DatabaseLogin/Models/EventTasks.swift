//
//  Models.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 31.03.2022.
//

import Foundation


class EventTasks: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var users: [User] = []
    @Published var usersId: [String] = []
}
