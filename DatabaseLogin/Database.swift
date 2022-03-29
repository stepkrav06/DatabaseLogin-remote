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
public func createUser(email: String, password: String) -> String? {
    var err: String?
    Auth.auth().createUser(withEmail: email, password: password) { _, error in
        if error != nil {
            err = error?.localizedDescription ?? ""
            print(err)
        }
    }
    print(err)
    return err
}
