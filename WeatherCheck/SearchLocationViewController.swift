//
//  SearchLocationViewController.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 29.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SearchLocationViewController: UIViewController {
        
        var fixedText:String = ""
        
        @IBOutlet var backGroundImageView: UIImageView!
        @IBOutlet var cityInputTxtField: UITextField!
    
    /*
    *   Open MainVC view. Send true to fb.auth
    */
        @IBAction func backItemBtnToolBar(sender: AnyObject) {
            let openMainVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! ViewController
            self.navigationController?.pushViewController(openMainVC, animated: true)
            openMainVC.auth = true
        }
    
    /*
    *   Search for the city, inpud value store in local db.
    */
        @IBAction func searchButton(sender: UIButton) {
            if fixedText.isEmpty == false{
                let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                let context: NSManagedObjectContext = appDelegate.managedObjectContext!
                
                let newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("City", inManagedObjectContext: context)
                newUser.setValue(fixedText, forKey: "name")
                do {
                    try context.save()
                } catch _ {
                }
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
            view.addGestureRecognizer(tap)
            
            buttonSkin()
        }
        
        /**
        *   Passing data from text input, about searching city to mainViewController. Fixed space issue in city name.
        */
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            let destViewController: ViewController = (segue.destinationViewController as? ViewController)!
            
            let fixTheText = cityInputTxtField.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
            if fixTheText.isEmpty == true{
                
                destViewController.passingData = "Berlin"
                destViewController.auth = true

            }else{
                fixedText = fixTheText
                destViewController.passingData = fixedText
                destViewController.auth = true
            }
        }
        
        /*
        *   Hide keaboard.
        */
        private func DismissKeyboard(){
            view.endEditing(true)
        }
        
        /*
        *   Update skin of search buttons.
        */
        private func buttonSkin(){
            self.backGroundImageView.backgroundColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
            self.navigationController!.toolbar.barTintColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
            self.navigationController!.toolbar.layer.borderWidth = 0.5
            self.navigationController!.toolbar.layer.borderColor = UIColor.whiteColor().CGColor
        }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
        
}