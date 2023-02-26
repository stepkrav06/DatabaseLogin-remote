//
//  Event.swift
//
//  Used to organize and store the information about the planned events
//
//

import Foundation
import Firebase



public struct Event: Identifiable, Equatable, Hashable {
    // instance variables
    public let id = UUID()
    var sid: String
    var name: String
    var startDate: Date
    var endDate: Date
    var isCharity: Bool
    var charitySum: String
    var tasks: [String]
    // constructor method 1
    init(name: String, startDate: Date, endDate: Date, isCharity: Bool) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.charitySum = "0"
        self.tasks = ["placeholder"]
    }
    // constructor method 2
    init(name: String, startDate: Date, endDate: Date, isCharity: Bool, charitySum: String) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.charitySum = charitySum
        self.tasks = ["placeholder"]
    }
    // constructor method 3
    init(name: String, startDate: Date, endDate: Date, isCharity: Bool, tasks: [String]) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.charitySum = "0"
        self.tasks = tasks
    }
    // constructor method 4
    init(name: String, startDate: Date, endDate: Date, isCharity: Bool, charitySum: String, tasks: [String]) {
        self.sid = id.uuidString
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.isCharity = isCharity
        self.charitySum = charitySum
        self.tasks = tasks
    }
    // constructor method 5 (for loading from the database)
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
    // a function to trasform an Event object to a JSON string for writing to the database
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
