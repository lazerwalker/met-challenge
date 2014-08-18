//
//  UIColor+Extensions.swift
//  MetMap
//
//  Created by Michael Walker on 8/17/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex:String) {
        var hexInt = UnsafeMutablePointer<UInt32>.alloc(1)

        let scanner = NSScanner(string:hex)
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "#")
        scanner.scanHexInt(hexInt)

        let red:CGFloat = CGFloat((hexInt.memory & 0xFF0000) >> 16)/255
        let green = CGFloat((hexInt.memory & 0xFF00) >> 8)/255
        let blue = CGFloat(hexInt.memory & 0xFF)/255

        return self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

}