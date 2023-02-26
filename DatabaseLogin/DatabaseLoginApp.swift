//
//  DatabaseLoginApp.swift
//
//  The app
//
//

import SwiftUI
import Firebase

@main
struct DatabaseLoginApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    var body: some Scene {
        WindowGroup {
            // environment objects created and passed into the main view
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
        // Firebase and push messaging configuration
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNs)
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
    // function saving the device token for push messaging on app launch
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
    // function for handling notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        
        print(userInfo)

        
            return [[.banner, .badge, .sound]]
      }
    // function for handling notifications
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo

        print(userInfo)
      }
    // function for handling notifications
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      print(userInfo)

      return UIBackgroundFetchResult.newData
    }
    // function for handling notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    // function for handling notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
}
