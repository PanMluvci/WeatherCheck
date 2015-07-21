//
//  LocationViewController.swift
//  WeatherCheck
//
//  Created by Josef Antoni.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LocationViewController: UIViewController{
    
    var fixedText:String = ""
    
    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var cityInputTxtField: UITextField!    
    
    @IBAction func backItemBtnToolBar(sender: AnyObject) {
        let openLocationVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! ViewController
        self.navigationController?.pushViewController(openLocationVC, animated: true)
    }
    
    @IBAction func searchButton(sender: UIButton) {
        if fixedText.isEmpty == false{
        var appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("City", inManagedObjectContext: context)
            newUser.setValue(fixedText, forKey: "name")
            context.save(nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        buttonSkin()
    }
    
    /**
    *   Passing data from text input, about searching city to mainViewController. Fixed space issue in city name.
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destViewController: ViewController = (segue.destinationViewController as? ViewController)!

        var fixTheText = cityInputTxtField.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        if fixTheText.isEmpty == true{
            
            destViewController.passingData = "Berlin"
        }else{
            fixedText = fixTheText
            destViewController.passingData = fixedText
        }
    }
    
    /*
    *   Causes the view (or one of its embedded text fields) to resign the first responder status. Hide keaboard.
    */
    func DismissKeyboard(){
        view.endEditing(true)
    }

    /*
    *   Skin update for search buttons.
    */
    func buttonSkin(){
        self.backGroundImageView.backgroundColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.barTintColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.layer.borderWidth = 0.5
        self.navigationController!.toolbar.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
   
}