//
//  Museum.swift
//  MetMap
//
//  Created by Michael Walker on 8/18/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import Foundation

class Museum {
    let floors:[Floor]

    init(dict:JSONValue) {
        var error: NSError?

        if let floors = dict["floors"].array {
            self.floors = floors
                .map { Floor.createWithJSONValue($0) }
                .filter { !($0 == nil) }
                .map { $0! }
        } else {
            self.floors = []
        }
    }

    init(floors:[Floor]) {
        self.floors = floors
    }
}

extension Museum : Printable {
    var description: String {
        var string = "Museum\n------\n"
        for floor in floors {
            string += floor.description
        }
        return string
    }
}
