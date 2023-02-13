//
//  Event.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 13.02.2023.
//

import Foundation
import Firebase



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
