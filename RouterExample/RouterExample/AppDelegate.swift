//
//  AppDelegate.swift
//  RouterExample
//
//  Created by aoxingkui on 2020/7/20.
//  Copyright © 2020 aosic. All rights reserved.
//

import UIKit
import BSHRouter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Router.autoRegister(with: self)
        Router.shared.urlProtocolHeader = "router://"
        Router.shared.errorHandler = {
            (text) in
            print(text)
        }
        Router.register(key: "router:3003") { (url, value) in
            print(url, value)
        }
        Router.register(key: "router:3004", className: "BViewController")
        return true
    }

    // MARK: UISceneSession Lifecycle

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

