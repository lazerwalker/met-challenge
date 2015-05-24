//
//  Floor.swift
//  MetMap
//
//  Created by Michael Walker on 8/17/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

class Floor {
    let name:String
    let map:MapFloor
    let wings:[Wing]

    class func createWithJSONValue(json:JSONValue) -> Floor? {
        if !json.hasKeys(["name", "map", "wings"]){
            return nil
        }

        let name = json["name"].string!
        let map = MapFloor(rawValue: json["map"].string!)!
        let wingDicts:[JSONValue] = json["wings"].array!

        var wings = wingDicts
            .map { Wing.createWithJSONValue($0, floor:map) }
            .filter { !($0 == nil) }
            .map { $0! }

        return Floor(name:name, map:map, wings:wings)
    }

    init(name:String, map:MapFloor, wings:Array<Wing>) {
        self.name = name
        self.wings = wings
        self.map = map
    }
}

extension Floor: Printable {
    var description: String {
        var string = "Floor: '\(name)'\n"

        for wing in wings {
            string += "\t\(wing)\n"
        }
        return string;
    }
}
