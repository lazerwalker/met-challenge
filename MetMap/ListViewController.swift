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

    override func awakeFromNib() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK - UITableViewDelegate
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as UITableViewCell
        return cell
    }

    override func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {
        let wing = floors[indexPath.section].wings[indexPath.row]
        cell.backgroundColor = wing.color
        cell.textLabel.text = wing.name
//        cell.detailTextLabel.text = "\(wing.startRoom) - \(wing.endRoom)"
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
}
