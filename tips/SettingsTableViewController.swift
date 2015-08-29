//
//  SettingsTableViewController.swift
//  tips
//
//  Created by Daniel Mathews on 8/13/15.
//  Copyright (c) 2015 Daniel Mathews. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var smallLabel: UITextField!
    @IBOutlet weak var mediumLabel: UITextField!
    @IBOutlet weak var largeLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        loadSettings()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func loadSettings() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let small = defaults.stringForKey("small") {
            self.smallLabel.text = small
            self.tipControl.setTitle("\(small)%", forSegmentAtIndex: 0)
        }
        if let medium = defaults.stringForKey("medium") {
            self.mediumLabel.text = medium
            self.tipControl.setTitle("\(medium)%", forSegmentAtIndex: 1)
        }
        if let large = defaults.stringForKey("large") {
            self.largeLabel.text = large
            self.tipControl.setTitle("\(large)%", forSegmentAtIndex: 2)
        }
        var index = defaults.integerForKey("tipindex")
        self.tipControl.selectedSegmentIndex = index
    }
    
    @IBAction func changedSettings(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(self.smallLabel.text, forKey: "small")
        defaults.setValue(self.mediumLabel.text, forKey: "medium")
        defaults.setValue(self.largeLabel.text, forKey: "large")
        if let small = defaults.stringForKey("small") {
            self.tipControl.setTitle("\(small)%", forSegmentAtIndex: 0)
        }
        if let medium = defaults.stringForKey("medium") {
            self.tipControl.setTitle("\(medium)%", forSegmentAtIndex: 1)
        }
        if let large = defaults.stringForKey("large") {
            self.tipControl.setTitle("\(large)%", forSegmentAtIndex: 2)
        }
        defaults.setInteger(self.tipControl.selectedSegmentIndex, forKey: "tipindex")
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
