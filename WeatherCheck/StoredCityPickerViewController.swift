//
//  StoredCityPickerViewController.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 17.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation
import UIKit

class StoredCityPickerViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSkin()
    }
    
    /**
    *   Passing data from text input, about searching city to mainViewController. Fixed space issue in city name.
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destViewController: ViewController = (segue.destinationViewController as? ViewController)!
       // destViewController.passingData = cityInputTxtField.text!.
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