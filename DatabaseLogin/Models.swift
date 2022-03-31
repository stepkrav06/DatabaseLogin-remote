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
    let id = UUID().uuidString
    var name: String
    var startDate: String
    var endDate: String
    var isCharity: Bool
    var tasks: [UUID]
    
}
public struct Task {
    let id = UUID().uuidString
    var content: String
    var importance: Int
    init(content: String, importance: Int) {
        self.content = content
        self.importance = importance
    }
}
//public func AddUser(){
//    let task1 = Task(content: "bubu1", importance: 1)
//    let task2 = Task(content: "bubu2", importance: 2)
//    let user = User(name: "bob", lastName: "bob", isAdmin: true, tasks: [task1.id, task2.id])
//    let ref = Database.database().reference(withPath: "users")
//    let userRef = ref.child(user.uid)
//    userRef.setValue(user.toAnyObject())
//    
//}
