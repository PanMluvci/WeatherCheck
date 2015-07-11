//
//  ViewController.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 10.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet var townLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    let locationManager = CLLocationManager()
    var locValue = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Berlin,de")

        //getWeatherData("http://api.openweathermap.org/data/2.5/weather?lat=" + "\(locValue.latitude)" + "&lon=" + "\(locValue.longitude)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    *
    */
    func getWeatherData(urlString: String) {
        let url = NSURL(string: urlString)
        
        // print("This: " + urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.setLabels(data!)
            })
        }
        task.resume()
    }
    
    /*
    *
    */
    func setLabels(weatherData: NSData) {
        var jsonError:NSError?
        
        let json = NSJSONSerialization.JSONObjectWithData(weatherData, options: nil, error: &jsonError) as! NSDictionary
        if let name = json["name"] as? String{
            townLabel.text = name
        }
        
        if let sys = json[("sys")] as? NSDictionary {
            if let country = sys[("country")] as? String {
                countryLabel.text = country
                
            }
        }
        
        if let main = json[("main")] as? NSDictionary {
            if let temp = main[("temp")] as? Double {
                //convert kelvin to celsius and rounding the double number
                let celsiusTemp = ((temp - 273.15))
                let roundCelsiusTemp = Double(round(10*celsiusTemp)/10)
                let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
                temperatureLabel.text = myStringRoundedCelsiusTemp + ("°C")
                
            }
        }
    }
    /*
    *
    */
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
       // println("\(locValue.latitude) \(locValue.longitude)")
        println("something \(locValue.latitude)" + "")
        locationManager.stopUpdatingLocation()
    }
    
    /*
     *   handler for err
     */
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("ERR " + error.localizedDescription)
    }
    
}

