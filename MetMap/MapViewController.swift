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

    let InitialMapScale : CGFloat = 0.2

    // MARK - Constructors
    init(floor: MapFloor) {
        super.init()
        self.floor = floor
    }

    required init(coder aDecoder: NSCoder!) {
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
        scrollView.zoomScale = InitialMapScale
        view.addSubview(scrollView)

        let doubleTap = UITapGestureRecognizer(target: self, action: "didDoubleTap")
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController.navigationBarHidden = false
    }

    //MARK - UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }

    func didDoubleTap() {
        if scrollView.zoomScale > scrollView.maximumZoomScale {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(InitialMapScale, animated: true)
        }
    }
}