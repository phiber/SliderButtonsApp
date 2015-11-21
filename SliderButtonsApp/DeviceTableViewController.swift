//
//  DeviceTableViewController.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 10.10.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import UIKit

class DeviceTableViewController: UITableViewController, PeripheralNotifiable {
    
    // MARK: properties
    
    let bleManager = BLEManager()
    let devicesList = DevicesList()

    override func viewDidLoad() {
        super.viewDidLoad()
        //bleManager.register(devicesList)
        bleManager.register(self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
      //  self.tableView.registerClass(DeviceTableViewCell.self, forCellReuseIdentifier: "DeviceTableViewCell")

      //  scanForDevices()
    }
    
    func peripheralFound(identifier: String!, name: String?, rssi: NSNumber!) {
        self.devicesList.peripheralFound(identifier, name: name, rssi: rssi)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesList.getDevices().count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cell = tableView.dequeueReusableCellWithIdentifier("DeviceTableViewCell", forIndexPath: indexPath) as! DeviceTableViewCell

        let device = devicesList.getDevices()[indexPath.row]
        cell.nameLabel.text = device.name ?? "Unknown"
        let imageName = calculateImageNameForRssi(device.rssi)
        let image = UIImage(named: imageName)
        
        cell.deviceImageView.image = image
        cell.rssiLabel.text = device.rssi.stringValue
        
        return cell
    }
    
    func calculateImageNameForRssi(rssi: NSNumber!) -> String! {
        if (rssi.integerValue > -50) {
            return "strength5"
        } else if (rssi.integerValue > -60) {
            return "strength4"
        } else if (rssi.integerValue > -70) {
            return "strength3"
        } else if (rssi.integerValue > -80) {
            return "strength2"
        } else if (rssi.integerValue > -90) {
            return "strength1"
        } else {
            return "strength0"
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
