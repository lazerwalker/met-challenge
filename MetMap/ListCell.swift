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

    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
    }

    override func awakeFromNib() {
    }
}