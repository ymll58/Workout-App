//
//  AppDelegate.swift
//  work
//
//  Created by ii on 01.07.20.
//  Copyright © 2020 SwiftIAPTeam. All rights reserved.
// 11 Pro Max Identifier : 357A10FE-52A2-46C2-B519

import UIKit
import Firebase
import GoogleMobileAds
import UserNotifications
@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{

    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) ->
        Bool {
        // [START default_firestore]
            FirebaseApp.configure()
            GADMobileAds.sharedInstance().start(completionHandler: nil)
            //Push notification
            registerForPushNotifications()

            
    return true
    }
    
        
    func registerForPushNotifications() {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
                    print("Permission granted: \(granted)")
            }
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
}
