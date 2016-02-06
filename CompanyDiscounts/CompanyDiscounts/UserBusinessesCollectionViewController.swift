//
//  UserBusinessesCollectionViewController.swift
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/6/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

import UIKit
import CoreData
import Parse

private let reuseIdentifier = "Cell"

class UserBusinessesCollectionViewController: UICollectionViewController {

    var businesses = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User Profile"
        
//        let btnGoToSidebar = UIBarButtonItem(barButtonSystemItem: .Add, target: self.revealViewController(), action: "revealToggle:")
//        
//        self.navigationItem.leftBarButtonItem = btnGoToSidebar
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background3.png")!);
        
        let revealViewController = self.revealViewController();
        self.view!.addGestureRecognizer(revealViewController.panGestureRecognizer());

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "Business")
        
        do {
            let results = try self.managedContext.executeFetchRequest(fetchRequest)
            self.businesses = results as! [NSManagedObject]
            self.collectionView!.reloadData()
        }
        catch let err as NSError {
            print("Error: \(err)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            let username = currentUser!.username
            return username.mutableSetValueForKey("businesses").count
        } else {
            return 0
        }

        
        
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        return managedContext;
    }()

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
