//
//  ViewController.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 10.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var weather: Weather?
    
    @IBOutlet var townLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var sunRiseLabel: UILabel!
    @IBOutlet var sunSetLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    let locValue = CLLocationCoordinate2D()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        stringFromTimeInterval()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    *
    */
    func getWeatherData(urlString: String) {
        
        Alamofire.request(.GET, urlString, parameters: nil) .responseJSON { (req, res, json, error) in
            if(error != nil) {
                NSLog("Error: \(error)")
            } else {
                var weatherJson = JSON(json!)
                
                var id = weatherJson["id"].int
                var cityName = weatherJson["name"].string
                var temperature = weatherJson["main", "temp"].double
                
                var description = weatherJson["weather"][0]["description"].stringValue
                
                self.weather = Weather(id: id!, name: cityName!, temp: temperature!, desc: description)
                self.setLabels()
            }
        }
    }
    
    /*
    *weatherData: NSData
    */
    func setLabels() {
        
        if let name = self.weather?.name{
            self.townLabel.text = name
        }
        
        if let description = self.weather?.desc{
            self.descriptionLabel.text = description
        }
        
        if let temp = self.weather?.temp{
            let celsiusTemp = ((temp - 273.15))
            let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
            let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
            self.temperatureLabel.text = myStringRoundedCelsiusTemp + ("°C")
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
    
    func stringFromTimeInterval() {
        let timestampAsInt: Int = 1436587010
        
        // and the method takes a Double, it needs to be
        // explicitly converted to a Doubl
        //var date = (NSDate(timeIntervalSince1970: int(timestampAsInt)))
        /*let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm"
        let date = dateFormatter.dateFromString(timestampAsDoubleb)
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components((.CalendarUnitHour | .CalendarUnitMinute), fromDate: date!)
        let hour = comp.hour
        let minute = comp.minute*/
       // println("\(date)")
    }
    
}

