//
//  FTUEViewController.swift
//  MetMap
//
//  Created by Michael Walker on 8/26/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class FTUEViewController: UIPageViewController, UIPageViewControllerDataSource {
    let vcs = [FTUEViewController1(), FTUEViewController2(), FTUEViewController3(), FTUEViewController4(), FTUEViewController5()]

    override init() {
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.dataSource = self

        self.setViewControllers([vcs[0]], direction: .Forward, animated: false, completion: nil)
    }

    required init(coder aDecoder: NSCoder) {
        return super.init(coder: aDecoder)
    }

    //MARK -
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    //MARK - UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController!, viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {
        let index = vcs.indexOf(viewController)! + 1
        if (index == vcs.count) { return nil; }
        return vcs[index]
    }

    func pageViewController(pageViewController: UIPageViewController!, viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {
        let index = vcs.indexOf(viewController)! - 1
        if (index == -1) { return nil; }
        return vcs[index]
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 5
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return vcs.indexOf(viewControllers[0] as UIViewController)!
    }
}
