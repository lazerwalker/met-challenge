//
//  FTUI1ViewController.swift
//  MetMap
//
//  Created by Michael Walker on 8/26/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class FTUEViewController4: UIViewController {
    override init() {
        super.init(nibName: "FTUEViewController4", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        for subview in view.subviews {
            println(subview)
        }
    }
}
