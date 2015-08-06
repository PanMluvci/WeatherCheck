//
//  StoredCityPickerViewController.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 17.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StoredCityPickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var myList : Array<AnyObject> = []
    var passedCityNameFromTable = ""
    var valueToPass = "Berlin"
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBAction func backItemBtnToolBar(sender: AnyObject) {
        let openMainVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! ViewController
        self.navigationController?.pushViewController(openMainVC, animated: true)
        openMainVC.auth = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSkin()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool){
        
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        var request = NSFetchRequest(entityName: "City")
        
        myList = context.executeFetchRequest(request, error: nil)!
        
        tableView.reloadData()
    }
    
    /**
    *   Return a number of rows in Table
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myList.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /*
    *   Add all stored cities from database to the row in table. Use capital letters style.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID: NSString = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as! UITableViewCell
        
        if let ip = indexPath as NSIndexPath? {
            //adding values to cells
            var data: NSManagedObject = myList[ip.row] as! NSManagedObject
            var s = data.valueForKeyPath("name") as? String
            var fixedText = s!.stringByReplacingOccurrencesOfString("%20", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            cell.textLabel?.text = fixedText.uppercaseString
            
        }
        return cell
    }
    
    /*
    *   Add value from selected row for searched city. Call segue.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        //optional => unwrap
        let text = cell?.textLabel?.text
        if let text = text {
            passedCityNameFromTable = text
            valueToPass = text
            performSegueWithIdentifier("tableData", sender: self)
        }
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /*
    *   Delete the row you dont want to see in list.
    */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            if let tv = tableView as UITableView? {
                
                context.deleteObject(myList[indexPath.row] as! NSManagedObject)
                myList.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            var error: NSError? = nil
            if !context.save(&error){
                abort()
            }
        }
    }
    
    /**
    *   Pass data from text input, about searching city to ViewController. Fix space issue in city name.
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "tableData") {
            
            var mainVC = segue.destinationViewController as! ViewController
            var fixedText = valueToPass.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
            mainVC.passingData = fixedText
            mainVC.auth = true
        }
        
    }
    
    /*
    *   Skin update for search buttons.
    */
    func buttonSkin(){
        self.backgroundImageView.backgroundColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.barTintColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.layer.borderWidth = 0.5
        self.navigationController!.toolbar.layer.borderColor = UIColor.whiteColor().CGColor
    }
}