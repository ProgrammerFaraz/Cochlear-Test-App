//
//  AppDelegate.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 29/10/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.rootViewController = LocationsDependencyProvider.navigationController
        return true
    }
}

