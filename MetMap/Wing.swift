//
//  Wing.swift
//  MetMap
//
//  Created by Michael Walker on 8/17/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class Wing {
    let name:String
    let color:UIColor
    let floor:MapFloor

    let startRoom:Int
    let endRoom:Int

    let mapRect:CGRect

    let userDefaults = NSUserDefaults.standardUserDefaults()
    let storageKey:String

    var completed:Bool {
        didSet {
            userDefaults.setBool(completed, forKey: storageKey)
            userDefaults.synchronize()
        }
    }
    class func createWithJSONValue(json:JSONValue, floor: MapFloor) -> Wing? {
        if !json.hasKeys(["name", "startRoom", "endRoom", "color", "size", "origin"]){
            return nil
        }

        let name = json["name"].string!
        let startRoom = json["startRoom"].integer!
        let endRoom = json["endRoom"].integer!

        let color = UIColor(hex: json["color"].string!)

        let origin = CGPoint(x: json["origin"][0].integer!, y: json["origin"][1].integer!)
        let size = CGSize(width: json["size"][0].integer!, height: json["size"][1].integer!)
        let rect = CGRect(origin: origin, size: size)

        return Wing(name: name, startRoom: startRoom, endRoom: endRoom, color: color, mapRect: rect, floor: floor)
    }

    init(name:String, startRoom:Int, endRoom:Int, color:UIColor, mapRect:CGRect, floor: MapFloor) {
        self.name = name
        self.startRoom = startRoom
        self.endRoom = endRoom
        self.color = color
        self.mapRect = mapRect
        self.floor = floor

        self.storageKey = "\(floor.toRaw())-\(name)"
        self.completed = userDefaults.boolForKey(storageKey)
    }
}

extension Wing: Printable {
    var description: String {
        return "Wing: '\(name)' (\(self.startRoom)-\(self.endRoom))"
    }
}
