//
//  Models.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 31.03.2022.
//

import Foundation
import Firebase

public struct User: Identifiable, Equatable, Hashable {
    public let id = UUID()
    var uid: String
    var email: String
    var isAdmin: Bool
    var name: String
    var lastName: String
    var tasks: [String]
    var grade: String
    
    
    init(uid: String, email: String, name: String, lastName: String, isAdmin: Bool, tasks: [String], grade: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.lastName = lastName
        self.isAdmin = isAdmin
        self.tasks = tasks
        self.grade = grade
    }
    init(uid: String, email: String, name: String, lastName: String, isAdmin: Bool, grade: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.lastName = lastName
        self.isAdmin = isAdmin
        self.tasks = ["placeholder"]
        self.grade = grade
    }
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

public struct Event: Identifiable, Equatable, Hashable {
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
        "startDate": startDate.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru"))),
        "endDate": endDate.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru"))),
        "isCharity": isCharity,
        "charitySum": charitySum,
        "tasks": tasks as NSArray
      ]
    }
    

}
public struct Task: Identifiable{
    public let id = UUID()
    var sid: String
    var name: String
    var description: String
    var importance: String
    var pplAssigned: String
    var people: [String]
    init(name: String, importance: String, description: String, ppl: Int, people: [String]) {
        self.sid = self.id.uuidString
        self.name = name
        self.description = description
        self.pplAssigned = String(ppl)
        self.importance = importance
        self.people = people
    }
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let name = value["name"] as? String,
        let description = value["description"] as? String,
        let pplAssigned = value["pplAssigned"] as? String,
        let importance = value["importance"] as? String,
        let people = value["people"] as? NSArray as? [String],
        let sid = value["sid"] as? String
        
        
      else {
        return nil
      }
        self.sid = sid
        self.name = name
        self.description = description
        self.pplAssigned = pplAssigned
        self.importance = importance
        self.people = people
        
        
        
    }
    func toAnyObject() -> Any {
      return [
        "sid": sid,
        "name": name,
        "description": description,
        "pplAssigned": pplAssigned,
        "people": people,
        "importance": importance
      ]
    }
}
public struct Grade{
    var attendance: Bool
    var activity: String
    var comments: String
    init(attendance: Bool, activity: String, comments: String) {
        self.attendance = attendance
        self.activity = activity
        self.comments = comments
    }
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let attendance = value["attendance"] as? Bool,
        let activity = value["activity"] as? String,
        let comments = value["comments"] as? String
        
        
      else {
        return nil
      }
        self.attendance = attendance
        self.activity = activity
        self.comments = comments
        
        
    }
    func toAnyObject() -> Any {
      return [
        "attendance": attendance,
        "activity": activity,
        "comments": comments
      ]
    }
}

class EventTasks: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var users: [User] = []
    @Published var usersId: [String] = []
}
