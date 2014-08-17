//
//  Floor.swift
//  MetMap
//
//  Created by Michael Walker on 8/17/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

class Floor {
    let name:String
    let wings:[Wing]

    class func createWithJSONValue(json:JSONValue) -> Floor? {
        let name = json["name"].string!
        let wingDicts:[JSONValue] = json["wings"].array!

        var hasInvalidWing:Bool = false
        let possibleWings:[Wing?]! = wingDicts.map {
            let wing = Wing.createWithJSONValue($0)
            if let foo = wing {} else {
                hasInvalidWing = true
            }
            return wing
        }

        if hasInvalidWing {
            return nil;
        }

        let wings:[Wing] = possibleWings.map { return $0! }
        return Floor(name:name, wings:wings)
    }

    init(name:String, wings:Array<Wing>) {
        self.name = name
        self.wings = wings
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
