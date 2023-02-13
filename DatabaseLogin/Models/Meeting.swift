//
//  Meeting.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 13.02.2023.
//

import Foundation
import Firebase


public struct Meeting{
    var date: Date
    var location: String
    var comments: String
    init(date: Date, location: String, comments: String) {
        self.date = date
        self.location = location
        self.comments = comments
    }
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let date = value["date"] as? String,
        let location = value["location"] as? String,
        let comments = value["comments"] as? String
        
        
      else {
        return nil
      }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy,HH:mm"
        self.date = dateFormatter.date(from: date)!
        self.location = location
        self.comments = comments
        
        
    }
    func toAnyObject() -> Any {
      return [
        "date": date.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).hour(.defaultDigits(amPM: .omitted)).minute(.defaultDigits).locale(Locale(identifier: "ru"))),
        "location": location,
        "comments": comments
      ]
    }
}
