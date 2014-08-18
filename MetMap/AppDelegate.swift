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

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        return true
    }
}

