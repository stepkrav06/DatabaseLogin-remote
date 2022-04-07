//
//  Models.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 31.03.2022.
//

import Foundation
import Firebase

public struct User: Identifiable {
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

public struct Event {
    let id = UUID()
    var sid: String
    var name: String
    var startDate: String
    var endDate: String
    var isCharity: Bool
    var tasks: [String]
    
    init(name: String, startDate: String, endDate: String, isCharity: Bool) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.tasks = ["placeholder"]
    }
    init(name: String, startDate: String, endDate: String, isCharity: Bool, tasks: [String]) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.tasks = tasks
    }
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let name = value["name"] as? String,
        let startDate = value["startDate"] as? String,
        let tasks = value["tasks"] as? NSArray as? [String],
        let isCharity = value["isCharity"] as? Bool,
        let endDate = value["endDate"] as? String,
        let sid = value["sid"] as? String
      else {
        return nil
      }

      self.name = name
        self.startDate = startDate
        self.endDate = endDate
      self.sid = sid
        self.isCharity = isCharity
        self.tasks = tasks
    }
    func toAnyObject() -> Any {
      return [
        "sid": sid,
        "name": name,
        "startDate": startDate,
        "endDate": endDate,
        "isCharity": isCharity,
        "tasks": tasks as NSArray
      ]
    }

}
public struct Task {
    let id = UUID()
    var content: String
    var importance: Int
    init(content: String, importance: Int) {
        self.content = content
        self.importance = importance
    }
}
