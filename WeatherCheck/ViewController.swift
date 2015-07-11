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
    
    @IBOutlet var minTempLabel: UILabel!
    
    @IBOutlet var maxTempLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let locValue = CLLocationCoordinate2D()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        

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
        if let weather = json[("weather")] as? NSDictionary {
            //if let description = weather[("main")] {
                townLabel.text = ("TEXT")
                
          //  }
        }
        if let description = json["description"] as? NSDictionary{
            townLabel.text = ("OK")
        }
        
        if let main = json[("main")] as? NSDictionary {
            if let temp = main[("temp")] as? Double {
                //convert kelvin to celsius and rounding the double number
                let celsiusTemp = ((temp - 273.15))
                let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
                let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
                temperatureLabel.text = myStringRoundedCelsiusTemp + ("°C")
                
            }
            if let minTemp = main[("temp_min")] as? Double {
                //convert kelvin to celsius and rounding the double number
                let celsiusTemp = ((minTemp - 273.15))
                let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
                let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
                minTempLabel.text = myStringRoundedCelsiusTemp + ("°C")
                
            }
            if let maxTemp = main[("temp_max")] as? Double {
                //convert kelvin to celsius and rounding the double number
                let celsiusTemp = ((maxTemp - 273.15))
                let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
                let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
                maxTempLabel.text = myStringRoundedCelsiusTemp + ("°C")
                
            }
        }
        
        
        
    }
    /*
    *   Store current location of device and calling ulr with position details -> getting all necessary information from
    */
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?lat=" + "\(locValue.latitude)" + "&lon=" + "\(locValue.longitude)")
        
    }
    
    /*
     *   handler for err
     */
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("ERR " + error.localizedDescription)
        //dopsat handler
    }
    
}
