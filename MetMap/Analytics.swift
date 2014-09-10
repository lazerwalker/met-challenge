//
//  Analytics.swift
//  MetMap
//
//  Created by Michael Walker on 9/10/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

class Analytics {
    class func start() {
        Flurry.startSession("CWVTPS8KXR5Y398Y9NVH")
    }

    class func track(event:String) {
        self.track(event, params:nil)
    }

    class func track(event:String, params:[String: AnyObject]?) {
        if let p = params {
            Flurry.logEvent(event, withParameters:p)
        } else {
            Flurry.logEvent(event)
        }
    }
}