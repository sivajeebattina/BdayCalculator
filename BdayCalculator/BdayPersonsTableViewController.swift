//
//  BdayPersonsTableViewController.swift
//  BdayCalculator
//
//  Created by pcs20 on 10/24/14.
//  Copyright (c) 2014 Paradigmcreatives. All rights reserved.
//

import UIKit

class BdayPersonsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="Birthdays On Today"
        
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable", name: "realoadData", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return UIApplication.sharedApplication().scheduledLocalNotifications.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bdayPerons", forIndexPath: indexPath) as UITableViewCell

        var localnotification=UIApplication.sharedApplication().scheduledLocalNotifications[indexPath.row]
        
        cell.textLabel?.text=localnotification.alertBody

        return cell
    }
    
    func reloadTable(){
    
       self.tableView.reloadData()
    
    }
    

   }
