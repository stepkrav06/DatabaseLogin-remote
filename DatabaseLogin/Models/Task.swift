//
//  Task.swift
//
//  Used to organize and store the information about the assigned tasks
//
//

import Foundation
import Firebase


public struct Task: Identifiable{
    // instance variables
    public let id = UUID()
    var sid: String
    var name: String
    var description: String
    var importance: String
    var pplAssigned: String
    var people: [String]
    // constructor method 1
    init(name: String, importance: String, description: String, ppl: Int, people: [String]) {
        self.sid = self.id.uuidString
        self.name = name
        self.description = description
        self.pplAssigned = String(ppl)
        self.importance = importance
        self.people = people
    }
    // constructor method 2 (for loading from the database)
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
    // a function to trasform a Task object to a JSON string for writing to the database
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
