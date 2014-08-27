//
//  FTUI1ViewController.swift
//  MetMap
//
//  Created by Michael Walker on 8/26/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class FTUEViewController5: UIViewController {
    override init() {
        super.init(nibName: "FTUEViewController5", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func didTapStartButton(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "seenFTUE")
        defaults.synchronize()
        
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
