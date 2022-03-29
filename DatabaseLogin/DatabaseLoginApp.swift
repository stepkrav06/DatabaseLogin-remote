//
//  DatabaseLoginApp.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 29.03.2022.
//

import SwiftUI
import Firebase

@main
struct DatabaseLoginApp: App {
    
    init(){
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
