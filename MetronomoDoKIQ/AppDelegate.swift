//
//  AppDelegate.swift
//  MetronomoDoKIQ
//
//  Created by Emannuel Carvalho on 22/08/17.
//  Copyright © 2017 Emannuel Carvalho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let nav = UINavigationController()
        let vc = ViewController()
        nav.viewControllers = [vc]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = nav
        return true
    }

    

}

