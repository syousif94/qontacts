//
//  AppDelegate.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/20/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit

var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var insets: UIEdgeInsets {
        return window!.safeAreaInsets
    }
    
    var notched: Bool {
        return insets.bottom > 0
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        window?.rootViewController = RootViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

