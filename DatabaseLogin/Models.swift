//
//  Models.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 31.03.2022.
//

import Foundation
import Firebase

public struct User: Identifiable, Equatable {
    public let id = UUID()
    var uid: String
    var email: String
    var isAdmin: Bool
    var name: String
    var lastName: String
    var tasks: [String]
    
    
    init(uid: String, email: String, name: String, lastName: String, isAdmin: Bool, tasks: [String]) {
        self.uid = uid
        self.email = email
        self.name = name
        self.lastName = lastName
        self.isAdmin = isAdmin
        self.tasks = tasks
    }
    init(uid: String, email: String, name: String, lastName: String, isAdmin: Bool) {
        self.uid = uid
        self.email = email
        self.name = name
        self.lastName = lastName
        self.isAdmin = isAdmin
        self.tasks = ["placeholder"]
    }
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let name = value["name"] as? String,
        let lastName = value["lastName"] as? String,
        let tasks = value["tasks"] as? NSArray as? [String],
        let isAdmin = value["isAdmin"] as? Bool,
        let email = value["email"] as? String,
        let uid = value["uid"] as? String
      else {
        return nil
      }

      self.name = name
        self.lastName = lastName
        self.isAdmin = isAdmin
      self.uid = uid
        self.tasks = tasks
        self.email = email
    }
    func toAnyObject() -> Any {
      return [
        "uid": uid,
        "email": email,
        "isAdmin": isAdmin,
        "name": name,
        "lastName": lastName,
        "tasks": tasks as NSArray
      ]
    }

    
}

public struct Event: Identifiable, Equatable {
    public let id = UUID()
    var sid: String
    var name: String
    var startDate: Date
    var endDate: Date
    var isCharity: Bool
    var charitySum: String
    var tasks: [String]
    
    init(name: String, startDate: Date, endDate: Date, isCharity: Bool) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.charitySum = "0"
        self.tasks = ["placeholder"]
    }
    init(name: String, startDate: Date, endDate: Date, isCharity: Bool, charitySum: String) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.charitySum = charitySum
        self.tasks = ["placeholder"]
    }
    init(name: String, startDate: Date, endDate: Date, isCharity: Bool, tasks: [String]) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.charitySum = "0"
        self.tasks = tasks
    }
    init(name: String, startDate: Date, endDate: Date, isCharity: Bool, charitySum: String, tasks: [String]) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.charitySum = charitySum
        self.tasks = tasks
    }
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let name = value["name"] as? String,
        let startDateString = value["startDate"] as? String,
        let tasks = value["tasks"] as? NSArray as? [String],
        let isCharity = value["isCharity"] as? Bool,
        let charitySum = value["charitySum"] as? String,
        let endDateString = value["endDate"] as? String,
        let sid = value["sid"] as? String
        
        
      else {
        return nil
      }
        self.name = name
        self.sid = sid
        self.isCharity = isCharity
        self.charitySum = charitySum
        self.tasks = tasks
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        self.endDate = dateFormatter.date(from: endDateString)!
        self.startDate = dateFormatter.date(from: startDateString)!
        
        
    }
    func toAnyObject() -> Any {
      return [
        "sid": sid,
        "name": name,
        "startDate": startDate.formatted(date: .numeric, time: .omitted),
        "endDate": endDate.formatted(date: .numeric, time: .omitted),
        "isCharity": isCharity,
        "charitySum": charitySum,
        "tasks": tasks as NSArray
      ]
    }
    

}
public struct Task: Identifiable{
    public let id = UUID()
    var sid: String
    var content: String
    var importance: String
    init(content: String, importance: String) {
        self.sid = self.id.uuidString
        self.content = content
        self.importance = importance
    }
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let content = value["content"] as? String,
        let importance = value["importance"] as? String,
        let sid = value["sid"] as? String
        
        
      else {
        return nil
      }
        self.sid = sid
        self.content = content
        self.importance = importance
        
        
        
    }
    func toAnyObject() -> Any {
      return [
        "sid": sid,
        "content": content,
        "importance": importance
      ]
    }
}

class EventTasks: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var users: [User] = []
}
