//
//  Tab.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 31.03.2022.
//

import Foundation
import SwiftUI

struct TabItemAdmin: Identifiable{
    var id = UUID()
    var text: String
    var icon: String
    var tab: TabAdmin
    var color: Color
}
var tabItemsAdmin = [
    TabItemAdmin(text: "Event", icon: "calendar", tab: .event, color: .teal),
    TabItemAdmin(text: "Tasks", icon: "square.and.pencil", tab: .tasks, color: .teal),
    TabItemAdmin(text: "Grading", icon: "text.badge.star", tab: .grading, color: .teal),
    TabItemAdmin(text: "Account", icon: "person", tab: .account, color: .teal),
    
]
enum TabAdmin: String {
    case event
    case tasks
    case grading
    case account
}
struct TabItemNonAdmin: Identifiable{
    var id = UUID()
    var text: String
    var icon: String
    var tab: TabNonAdmin
    var color: Color
}
var tabItemsNonAdmin = [
    TabItemNonAdmin(text: "Event", icon: "calendar", tab: .event, color: .teal),
    TabItemNonAdmin(text: "Tasks", icon: "square.and.pencil", tab: .tasks, color: .teal),
    TabItemNonAdmin(text: "Activity", icon: "chart.bar", tab: .activity, color: .teal),
    TabItemNonAdmin(text: "Account", icon: "person", tab: .account, color: .teal),
    
]

enum TabNonAdmin: String {
    case event
    case tasks
    case activity
    case account
}

