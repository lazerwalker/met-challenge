//
//  MapViewController.swift
//  MetMap
//
//  Created by Michael Walker on 8/19/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

enum MapFloor : String {
    case One = "Floor1"
    case TwoThree = "Floors23"
}

class MapViewController : UIViewController, UIScrollViewDelegate {
    let imageView = UIImageView()
    let scrollView = UIScrollView()

    var floor : MapFloor = .One

    var focusedWing : Wing?

    let InitialMapScale : CGFloat = 0.1

    // MARK - Constructors
    init(floor: MapFloor) {
        super.init()
        self.floor = floor
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
    }

    //MARK - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: floor.toRaw())
        imageView.image = image
        imageView.frame = CGRect(origin: CGPointZero, size: image.size)
        scrollView.contentSize = image.size
        scrollView.addSubview(imageView)

        scrollView.frame = view.frame
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.whiteColor()

        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 0.5
        scrollView.zoomScale = scrollView.minimumZoomScale
        view.addSubview(scrollView)

        let doubleTap = UITapGestureRecognizer(target: self, action: "didDoubleTap:")
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController.navigationBarHidden = false

        if let wing = focusedWing {
            navigationController.navigationBar.tintColor = wing.color

            let titleView = UILabel()
            titleView.text = wing.name
            titleView.sizeToFit()
            titleView.frame.size.height = 30.0

            titleView.adjustsFontSizeToFitWidth = true
            titleView.font = UIFont(name: "Optima-Bold", size: 20)
            titleView.numberOfLines = 0
            titleView.textAlignment = .Center
            titleView.textColor = wing.color
            navigationItem.titleView = titleView
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if let wing = focusedWing {
            var rect = wing.mapRect
            rect.origin.x -= (rect.size.width * 0.1)
            rect.origin.y -= (rect.size.height * 0.1)
            rect.size.width *= 1.2
            rect.size.height *= 1.2
            scrollView.zoomToRect(rect, animated: true)
        }

    }

    //MARK - UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }

    func didDoubleTap(sender: UITapGestureRecognizer) {
        if scrollView.zoomScale > InitialMapScale {
            scrollView.setZoomScale(InitialMapScale, animated: true)
        } else {
            scrollView.setZoomScale(0.3, animated: true)
        }
    }
}