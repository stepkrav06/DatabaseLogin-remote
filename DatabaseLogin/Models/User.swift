//
//  User.swift
//
//  Used to organize and store the information about the users of the app
//
//

import Foundation
import Firebase

public struct User: Identifiable, Equatable, Hashable {
    // instance variables
    public let id = UUID()
    var uid: String
    var email: String
    var isAdmin: Bool
    var name: String
    var lastName: String
    var tasks: [String]
    var grade: String
    
    // constructor method 1
    init(uid: String, email: String, name: String, lastName: String, isAdmin: Bool, tasks: [String], grade: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.lastName = lastName
        self.isAdmin = isAdmin
        self.tasks = tasks
        self.grade = grade
    }
    // constructor method 2
    init(uid: String, email: String, name: String, lastName: String, isAdmin: Bool, grade: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.lastName = lastName
        self.isAdmin = isAdmin
        self.tasks = ["placeholder"]
        self.grade = grade
    }
    // constructor method 3 (for loading from the database)
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let name = value["name"] as? String,
        let lastName = value["lastName"] as? String,
        let tasks = value["tasks"] as? NSArray as? [String],
        let isAdmin = value["isAdmin"] as? Bool,
        let email = value["email"] as? String,
        let grade = value["grade"] as? String,
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
        self.grade = grade
    }
    // a function to trasform a User object to a JSON string for writing to the database
    func toAnyObject() -> Any {
      return [
        "uid": uid,
        "email": email,
        "isAdmin": isAdmin,
        "name": name,
        "lastName": lastName,
        "grade": grade,
        "tasks": tasks as NSArray
      ]
    }

    
}
