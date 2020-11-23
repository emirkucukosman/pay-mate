//
//  AppDelegate.swift
//  PayMate
//
//  Created by Emir Küçükosman on 10.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UserDefaults.standard.string(forKey: "token") != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let rootVC = storyboard.instantiateViewController(identifier: "AccountVC")
            window?.rootViewController = rootVC
            window?.makeKeyAndVisible()
        }
        return true
    }

}

