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

    @IBAction func navigationBtn(sender: AnyObject) {
        
        let backToMainVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! ViewController
        self.navigationController?.pushViewController(backToMainVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}