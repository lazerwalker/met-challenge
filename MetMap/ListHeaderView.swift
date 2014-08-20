//
//  ListHeaderView.swift
//  MetMap
//
//  Created by Michael Walker on 8/20/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class ListHeaderView : UIView {
    @IBOutlet weak var percentageLabel: LTMorphingLabel!
    @IBOutlet weak var flavorLabel: UILabel!

    var percentage : Int = 0 {
        didSet {
            updatePercentageLabel()
        }
    }

    // MARK - Initializers
    class func loadFromNib() -> ListHeaderView! {
        return UINib(nibName: "ListHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as? ListHeaderView
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        percentageLabel.morphingEffect = .Evaporate
    }

    func updatePercentageLabel() {
        percentageLabel.text = "\(percentage)%"
        percentageLabel.sizeToFit()
        percentageLabel.setNeedsUpdateConstraints()
    }
}