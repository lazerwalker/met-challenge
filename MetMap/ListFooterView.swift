//
//  ListFooterView.swift
//  MetMap
//
//  Created by Michael Walker on 8/26/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class ListFooterView : UIView {
    var tapHandler:(()->())?

    override init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 50))

        let button:UIButton = UIButton.buttonWithType(.System) as UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("?", forState:.Normal)
        button.titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        button.tintColor = UIColor.grayColor()
        button.addTarget(self, action: "didTapQuestionMark", forControlEvents: .TouchUpInside)

        addSubview(button)

        addConstraint(NSLayoutConstraint(
            item: button, attribute: .Trailing,
            relatedBy: .Equal,
            toItem: self, attribute: .Trailing,
            multiplier: 1.0, constant: 0
        ))

        addConstraint(NSLayoutConstraint(
            item: button, attribute: .Height,
            relatedBy: .Equal,
            toItem: self, attribute: .Height,
            multiplier: 1.0, constant: 0
        ))

        addConstraint(NSLayoutConstraint(
            item: button, attribute: .Width,
            relatedBy: .Equal,
            toItem: nil, attribute: .NotAnAttribute,
            multiplier: 1.0, constant: 60
        ))

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didTapQuestionMark() {
        if let block = tapHandler {
            block()
        }
    }

}