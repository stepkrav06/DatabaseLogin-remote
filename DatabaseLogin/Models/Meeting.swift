//
//  Meeting.swift
//
//  Used to organize and store the information about the next upcoming meeting
//
//

import Foundation
import Firebase


public struct Meeting{
    // instance variables
    var date: Date
    var location: String
    var comments: String
    // constructor method 1
    init(date: Date, location: String, comments: String) {
        self.date = date
        self.location = location
        self.comments = comments
    }
    // constructor method 2 (for loading from the database)
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
    // a function to trasform a Meeting object to a JSON string for writing to the database
    func toAnyObject() -> Any {
      return [
        "date": date.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).hour(.defaultDigits(amPM: .omitted)).minute(.defaultDigits).locale(Locale(identifier: "ru"))),
        "location": location,
        "comments": comments
      ]
    }
}
