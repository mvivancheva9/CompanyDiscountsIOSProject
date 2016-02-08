//
//  ManageBusinessTableViewController.swift
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/7/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

import UIKit

var locationCounts = 0

class ManageBusinessTableViewController: UITableViewController {
    
    var locationsCoordinates = [PFGeoPoint]()
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background3.png")!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let businessId = (UIApplication.sharedApplication().delegate as! AppDelegate).data;
        let query = PFQuery(className:"Location")
        query.whereKey("businessId", equalTo:businessId)
        query.findObjectsInBackgroundWithBlock {
            
            (locations: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.tableView.reloadData()
                })
                locationCounts = locations!.count
                for location in locations!{
                    
                    self.locationsCoordinates.append((location["point"]) as! PFGeoPoint)
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return locationCounts
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ManageBusinessScene", forIndexPath: indexPath)
        
        let latitude = self.locationsCoordinates[indexPath.row].latitude
        let longitude = self.locationsCoordinates[indexPath.row].longitude
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            var locationName = placeMark.addressDictionary!["Name"] as? String
            if(locationName == nil){
                locationName = "Some Location"
            }
            var city = placeMark.addressDictionary!["City"] as? String
            if(city == nil){
                city = "Some City"
            }
            let address = city! + ", " + locationName!
            cell.textLabel?.text = address
            
            
        })
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete) {
            let location = self.locationsCoordinates[indexPath.row]
            
            let query = PFQuery(className:"Location")
            query.whereKey("point", equalTo:location)
            query.findObjectsInBackgroundWithBlock {
                
                (var locations: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    print(locations?.count)
                    locations?.removeAll()
                    self.locationsCoordinates.removeAtIndex(indexPath.row)
                    locationCounts = locationCounts - 1
                    self.tableView.reloadData()
                } else {
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
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
