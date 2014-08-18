//
//  ListViewController.swift
//  MetMap
//
//  Created by Michael Walker on 8/18/14.
//  Copyright (c) 2014 Mike Lazer-Walker. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController {
    let CellIdentifier = "Cell"

    let floors:[Floor]

    required init(coder aDecoder: NSCoder!) {
        var error: NSError?
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        let data = NSData.dataWithContentsOfFile(path, options: nil, error: &error)
        let dict = JSONValue(data)
        floors = Museum(dict: dict).floors

        super.init(coder:aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // TODO: This shouldn't be necessary.
        // Currently needed to trigger autosizing on the first screen of cells
        self.tableView.reloadData()
    }

    // MARK - UITableViewDelegate
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ListCell.self), forIndexPath:indexPath) as UITableViewCell

        let wing = wingForIndexPath(indexPath)

        // TODO: move all of these into the cell, and make RACified

        cell.textLabel.text = wing.name

        if (wing.completed) {
            cell.backgroundColor = wing.color.colorWithAlphaComponent(0.3)
            cell.accessoryType = .Checkmark
        } else {
            cell.backgroundColor = wing.color
            cell.accessoryType = .DisclosureIndicator
        }

        return cell
    }

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {

        let wing = wingForIndexPath(indexPath)
        wing.completed = !wing.completed

        tableView.reloadData()
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

    // MARK - Private
    func wingForIndexPath(indexPath:NSIndexPath) -> Wing {
        return floors[indexPath.section].wings[indexPath.row]
    }
}
