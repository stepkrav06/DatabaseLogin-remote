//
//  Grade.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 13.02.2023.
//

import Foundation
import Firebase


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
