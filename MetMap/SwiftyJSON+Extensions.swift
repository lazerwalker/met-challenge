//
//  SwiftyJSON+Extensions.swift
//  MetMap
//
//  Created by Michael Walker on 8/17/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import Foundation

extension JSONValue {
    func hasKeys(keys:[String]) -> Bool {
        for key:String in keys {
            switch self[key] {
                case .JInvalid(let error):
                    return false;
                default:
                    continue
            }
        }

        return true
    }
}