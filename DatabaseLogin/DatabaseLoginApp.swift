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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            let eventTasks = EventTasks()
            
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(eventTasks)

        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
}
