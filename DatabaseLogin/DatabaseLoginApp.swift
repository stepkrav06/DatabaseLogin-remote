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
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        return true
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        
        
        if fcmToken != nil{
        let ref = Database.database().reference(withPath: "deviceTokens")
        ref.observeSingleEvent(of :.value) { snapshot in
            
        
                
            var tokens = snapshot.value as? [String] ?? []
            
            if !tokens.contains(fcmToken!){
                tokens.append(fcmToken!)
            }
            
            ref.setValue(tokens)
                    
                
            
        
        } withCancel: { error in
            print(error.localizedDescription)
        }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        
        print(userInfo)

        
            return [[.banner, .badge, .sound]]
      }

      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo

        print(userInfo)
      }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      print(userInfo)

      return UIBackgroundFetchResult.newData
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
}
