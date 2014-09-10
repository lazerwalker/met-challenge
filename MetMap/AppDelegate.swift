//
//  AppDelegate.swift
//  MetMap
//
//  Created by Michael Walker on 8/17/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {

        let controller = ListViewController()
        let navController = UINavigationController(rootViewController: controller)

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        if !NSUserDefaults.standardUserDefaults().boolForKey("seenFTUE") {
            let ftue = FTUEViewController()
            navController.presentViewController(ftue, animated: false, completion: nil)
        }

        Analytics.start()
        
        return true
    }
}

