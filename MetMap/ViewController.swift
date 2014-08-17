//
//  ViewController.swift
//  MetMap
//
//  Created by Michael Walker on 8/17/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        var error: NSError?

        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        let data = NSData.dataWithContentsOfFile(path, options: nil, error: &error)
        let dict = JSONValue(data)

        let floors = dict["floors"].array!
        for floor in floors {
            if let f = Floor.createWithJSONValue(floor) {
                println(f)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

