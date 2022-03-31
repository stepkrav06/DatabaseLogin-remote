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
