//
//  LocationViewController.swift
//  WeatherCheck
//
//  Created by Josef Antoni.
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
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        buttonSkin()
    }
    
    /**
    *   Passing data from text input, about searching city to mainViewController. Fixed space issue in city name.
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destViewController: ViewController = (segue.destinationViewController as? ViewController)!
        destViewController.passingData = cityInputTxtField.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
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
        searchButton.backgroundColor = UIColor.clearColor()
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.backgroundImageView.backgroundColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.barTintColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.layer.borderWidth = 0.5
        self.navigationController!.toolbar.layer.borderColor = UIColor.whiteColor().CGColor
    }
}