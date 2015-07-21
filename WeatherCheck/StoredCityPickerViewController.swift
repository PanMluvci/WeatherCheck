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
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundImageView: UIImageView!
    
    var myList : Array<AnyObject> = []
    var passedCityNameFromTable = ""
    
    @IBAction func backItemBtnToolBar(sender: AnyObject) {
        let openLocationVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! ViewController
        self.navigationController?.pushViewController(openLocationVC, animated: true)
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

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
    *   Return a number of rows in Table
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID: NSString = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as! UITableViewCell
        
        if let ip = indexPath as NSIndexPath? {
            
            var data: NSManagedObject = myList[ip.row] as! NSManagedObject
            cell.textLabel?.text = data.valueForKeyPath("name") as? String
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let indexPath = tableView.indexPathForSelectedRow();
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        
        passedCityNameFromTable == currentCell!.textLabel!.text
        println(passedCityNameFromTable)

    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
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
    *   Passing data from text input, about searching city to mainViewController. Fixed space issue in city name.
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destViewController: ViewController = (segue.destinationViewController as? ViewController)!
        
        if passedCityNameFromTable.isEmpty == true{
            
            println("TRUE")
        }else{
            destViewController.passingData = passedCityNameFromTable
            println(passedCityNameFromTable)
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