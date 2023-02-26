//
//  Grade.swift
//
//  Used to organize and store the information about the next grades given to students
//
//

import Foundation
import Firebase


public struct Grade{
    // instance variables
    var attendance: Bool
    var activity: String
    var comments: String
    // constructor method 1
    init(attendance: Bool, activity: String, comments: String) {
        self.attendance = attendance
        self.activity = activity
        self.comments = comments
    }
    // constructor method 2 (for loading from the database)
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
    // a function to trasform a Grade object to a JSON string for writing to the database
    func toAnyObject() -> Any {
      return [
        "attendance": attendance,
        "activity": activity,
        "comments": comments
      ]
    }
}
