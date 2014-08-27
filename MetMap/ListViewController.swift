//
//  ListViewController.swift
//  MetMap
//
//  Created by Michael Walker on 8/18/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit


class ListViewController : UITableViewController {
    let floors:[Floor] = []

    let headerView:ListHeaderView = ListHeaderView.loadFromNib()

    // Because of weird Swift things, calling init() causes this to be called.
    // Let's do all our initialization here.
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        var error: NSError?
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        let data = NSData.dataWithContentsOfFile(path!, options: nil, error: &error)
        let dict = JSONValue(data)
        floors = Museum(dict: dict).floors

        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }

    override init() {
        super.init(style:.Grouped)
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)

        tableView.tableHeaderView = ListHeaderView.loadFromNib()

        let footer = ListFooterView()
        tableView.tableFooterView = footer
        footer.tapHandler = {
            let ftue = FTUEViewController()
            self.navigationController.presentViewController(ftue, animated: true, completion: nil)
        }

        let nib = UINib(nibName:"ListCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "ListCell")

        updatePercentage()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController.navigationBarHidden = true
    }

    // MARK - 
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    // MARK - UITableViewDelegate
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath:indexPath) as ListCell

        let wing = wingForIndexPath(indexPath)
        cell.wing = wing
        cell.didChangeBlock = { (_) in self.updatePercentage() }

        return cell
    }

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let floor = floors[indexPath.section]
        let wing = wingForIndexPath(indexPath)

        let mapController = MapViewController(floor: floor.map)
        mapController.focusedWing = wing
        navigationController.pushViewController(mapController, animated: true)
    }

    // MARK - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return floors.count
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return floors[section].wings.count
    }

    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return floors[section].name
    }

    // MARK - ListViewController
    func updatePercentage() {
        (tableView.tableHeaderView as ListHeaderView).percentage = percentage()
    }

    func percentage() -> Int {
        let total = floors
            .map({ $0.wings })
            .flatten() as [Wing]

        let completed = total.filter({ $0.completed })

        return Int((Float(completed.count) / Float(total.count)) * 100)
    }

    // MARK - Private
    func wingForIndexPath(indexPath:NSIndexPath) -> Wing {
        return floors[indexPath.section].wings[indexPath.row]
    }
}
