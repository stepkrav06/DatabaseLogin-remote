//
//  Database.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 29.03.2022.
//

import Foundation
import Firebase

public let ref = Database.database().reference(withPath: "grocery-items")
public var refObservers: [DatabaseHandle] = []
public var createUserError: String?
public var logInError: String?
public func createUser(email: String, password: String) {
    
    Auth.auth().createUser(withEmail: email, password: password) { _, error in
        if error != nil {
            createUserError = error?.localizedDescription ?? ""
            print(createUserError!)
        }
        
    }
}
public func logIn(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { user, error in
      if let error = error, user == nil {
          logInError = error.localizedDescription
          print(error)
      }
    }
}
