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
    
    required init(coder aDecoder: NSCoder) {
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

        generateNewFlavorText()
    }

    // MARK - Flavor test
    let zeroPhrases = [
        "What are you waiting for?",
        "No time like the present!",
        "Take the first step!"
    ]

    let phrases = [
        "NICE!",
        "KEEP UP THE GREAT PACE.",
        "THAT'S PRETTY IMPRESSIVE.",
        "YOU'RE REALLY GOOD AT THIS.",
        "AT THIS RATE, YOU'LL BE DONE IN NO TIME!",
        "NOT BAD."
    ]

    func generateNewFlavorText() {
        var text:String = ""

        switch(percentage) {
            case 0:
                text = zeroPhrases.sample(size: 1).first!

            case 24...26:
                text = "A quarter done!"
            case 32...34:
                text = "A third of the way there!"
            case 49...51:
                text = "Halfway there!"
            case 65-67:
                text = "Two-thirds of the way!"
            case 74...76:
                text = "Three-quarters done!"
            case 95...99:
                text = "So close!"
            case 100:
                text = "You did it! 🎉"

            default:
                if (arc4random_uniform(4) == 1 || !contains(phrases, flavorLabel.text)) {
                    text = phrases.sample(size:1).first!
                } else {
                    text = flavorLabel.text
                }
        }

        UIView.transitionWithView(flavorLabel,
            duration: 0.2,
            options: .TransitionCrossDissolve,
            animations: {
                self.flavorLabel.text = text.uppercaseString
            },
            completion: nil)
    }
}