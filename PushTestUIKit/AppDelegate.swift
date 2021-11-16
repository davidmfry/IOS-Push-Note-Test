//
//  AppDelegate.swift
//  PushTestUIKit
//
//  Created by David Fry on 11/15/21.
//

import Firebase
//import FirebaseMessaging
import UserNotifications
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            guard success else {
                return
            }
            print("Success in APNS registry")
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        forwardTokenToServer(token: deviceToken)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print("Token: \(token)")
        }
    }
    

    // MARK: UISceneSession Lifecycle


}

func forwardTokenToServer(token: Data) {
    let tokenComponents = token.map { data in String(format: "%02.2hhx", data)}
    let deviceTokenString = tokenComponents.joined()
//    let queryItems = [URLQueryItem(name: "deviceToken", value: deviceTokenString)]
//    var urlComps = URLComponents(string: "www.example.com/registe_end_point")
//    urlComps?.queryItems = queryItems
//
//    guard let url = urlComps?.url else {
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: url) { data, response, error in
//        // Handle data
//    }
//
//    task.resume()
    
    print("Device Token String: \(deviceTokenString)")

}

