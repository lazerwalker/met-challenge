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
    @IBOutlet weak var checkmark: UIImageView!

    var didChangeBlock: ((Wing?)->())?

    var wing:Wing? {
        didSet {
            nameLabel.text = wing?.name

            if (wing?.completed == true) {
                backgroundColor = wing?.color.colorWithAlphaComponent(0.2)
                checkmark.highlighted = true
                checkmark.tintColor = UIColor(hex: "#007502").colorWithAlphaComponent(0.2)
                nameLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
            } else {
                backgroundColor = wing?.color
                checkmark.highlighted = false
                checkmark.tintColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
                nameLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
            }
        }
    }

    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .None

        checkmark.image = checkmark.image.imageWithRenderingMode(.AlwaysTemplate)
        checkmark.highlightedImage = checkmark.highlightedImage.imageWithRenderingMode(.AlwaysTemplate)

        let swipeToComplete = UISwipeGestureRecognizer(target: self, action: "complete")
        swipeToComplete.direction = .Right
        contentView.addGestureRecognizer(swipeToComplete)

        let swipeToUndo = UISwipeGestureRecognizer(target: self, action: "undo")
        swipeToUndo.direction = .Left
        contentView.addGestureRecognizer(swipeToUndo)

        let tap = UITapGestureRecognizer(target: self, action: "tappedCheckmark")
        checkmark.addGestureRecognizer(tap)
    }

    //MARK -
    func complete() {
        if (wing?.completed == false) {
            let tempWing = wing
            tempWing?.completed = true
            wing = tempWing

            if let block = didChangeBlock {
                block(wing)
            }
        }
    }

    func undo() {
        if (wing?.completed == true) {
            let tempWing = wing
            tempWing?.completed = false
            wing = tempWing

            if let block = didChangeBlock {
                block(wing)
            }
        }
    }

    func tappedCheckmark() {
        let tempWing = wing
        tempWing?.completed = !(tempWing!.completed)
        wing = tempWing

        if let block = didChangeBlock {
            block(wing)
        }
    }
}