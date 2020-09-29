//
//  AppDelegate.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 29.09.2020.
//  Copyright © 2020 MOB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let rootController = RootTabBarController()

        window!.rootViewController = rootController
        window!.makeKeyAndVisible()

        return true
    }
}

