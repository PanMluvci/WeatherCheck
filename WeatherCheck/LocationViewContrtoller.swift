//
//  LocationViewContrtoller.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 15.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation
import UIKit

class LocationViewController: UIViewController {

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var cityInputTxtField: UITextField!
    
    @IBAction func backItemBtnToolBar(sender: AnyObject) {
        let openLocationVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! ViewController
        self.navigationController?.pushViewController(openLocationVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImageView.backgroundColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.barTintColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.layer.borderWidth = 0.5
        self.navigationController!.toolbar.layer.borderColor = UIColor.whiteColor().CGColor
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
   
        searchButton.backgroundColor = UIColor.clearColor()
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    /**
    *   Passing data to mainViewController, datab about searching city
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destViewController: ViewController = (segue.destinationViewController as? ViewController)!
        
        destViewController.passingData = cityInputTxtField.text!
    }
    
    /*
    *   Causes the view (or one of its embedded text fields) to resign the first responder status.
    */
    func DismissKeyboard(){
        view.endEditing(true)
    }
}