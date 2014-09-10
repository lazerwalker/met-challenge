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
            renderWing(animated:(oldValue?.name == wing?.name))
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .None

        checkmark.image = checkmark.image?.imageWithRenderingMode(.AlwaysTemplate)
        checkmark.highlightedImage = checkmark.highlightedImage?.imageWithRenderingMode(.AlwaysTemplate)

        let swipeToComplete = UISwipeGestureRecognizer(target: self, action: "complete")
        swipeToComplete.direction = .Right
        contentView.addGestureRecognizer(swipeToComplete)

        let swipeToUndo = UISwipeGestureRecognizer(target: self, action: "undo")
        swipeToUndo.direction = .Left
        contentView.addGestureRecognizer(swipeToUndo)

        let tap = UITapGestureRecognizer(target: self, action: "tappedCheckmark")
        checkmark.addGestureRecognizer(tap)
    }

    // MARK -
    func renderWing(animated:Bool = false) {
        nameLabel.text = wing?.name

        let wingBlock: ()->() = {
            if (self.wing?.completed == true) {
                self.backgroundColor = self.wing?.color.colorWithAlphaComponent(0.2)
                self.checkmark.highlighted = true
                self.checkmark.tintColor = UIColor(hex: "#007502").colorWithAlphaComponent(0.2)
                self.nameLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
            } else {
                self.backgroundColor = self.wing?.color
                self.checkmark.highlighted = false
                self.checkmark.tintColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
                self.nameLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
            }
        }

        if (animated) {
            UIView.animateWithDuration(0.1, animations: wingBlock)
        } else {
            wingBlock()
        }

    }

    // MARK -
    func complete() {
        if (wing?.completed == false) {
            let tempWing = wing
            tempWing?.completed = true
            wing = tempWing

            Analytics.track("Completed", params:["wing":nameLabel.text!, "checkbox":"false"])

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

            Analytics.track("Undo", params:["wing":nameLabel.text!, "checkbox":"false"])

            if let block = didChangeBlock {
                block(wing)
            }
        }
    }

    func tappedCheckmark() {
        let tempWing = wing
        let completed = !(tempWing!.completed)
        tempWing?.completed = completed
        wing = tempWing

        let params = ["wing":nameLabel.text!, "checkbox":"true"]
        let event = completed ? "Completed" : "Undo"
        Analytics.track(event, params:params)

        if let block = didChangeBlock {
            block(wing)
        }
    }
}