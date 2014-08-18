//
//  ListCell.swift
//  MetMap
//
//  Created by Michael Walker on 8/18/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class ListCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    var wing:Wing? {
        didSet {
            nameLabel.text = wing?.name

            if (wing?.completed == true) {
                backgroundColor = wing?.color.colorWithAlphaComponent(0.2)
                nameLabel.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
            } else {
                backgroundColor = wing?.color
                nameLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
            }
        }
    }

    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
    }
}