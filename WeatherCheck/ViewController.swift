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
    var passingData = String("")
    
    let locationManager = CLLocationManager()
    let locValue = CLLocationCoordinate2D()
    
    @IBOutlet var townLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var sunRiseLabel: UILabel!
    @IBOutlet var sunSetLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var pressurelabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var cloudsLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var srollingInfoLabel: UIScrollView!

    @IBOutlet var searchCityBtn: UIBarButtonItem!
    /*
    *   Navigate and open LocationViewController after pressing the button
    */
    @IBAction func navigationBtnToLocationVC(sender: AnyObject) {
        
        let openLocationVC = self.storyboard?.instantiateViewControllerWithIdentifier("LocationVC") as! LocationViewController
        self.navigationController?.pushViewController(openLocationVC, animated: true)
    }
    
    @IBAction func navigationBtnToStoredCityVC(sender: AnyObject) {
        
        let openLocationVC = self.storyboard?.instantiateViewControllerWithIdentifier("StoredCityVC") as! StoredCityPickerViewController
        self.navigationController?.pushViewController(openLocationVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        srollingInfoLabel.contentSize.height = 500
        descriptionLabel.layer.borderWidth = 0.5
        descriptionLabel.layer.borderColor = UIColor.whiteColor().CGColor
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
       // self.locationManager.startUpdatingLocation()
        self.navigationController!.toolbar.barTintColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.layer.borderWidth = 0.5
        self.navigationController!.toolbar.layer.borderColor = UIColor.whiteColor().CGColor
        self.backgroundImageView.backgroundColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        
        
        searchingForCity(passingData)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    * Search for the city's weather status.
    * If no start value in searched city, then use the current location.
    */
    func searchingForCity(data:String){
        if(passingData.isEmpty == false){
            getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(passingData)")
        }else{
            self.locationManager.startUpdatingLocation()
        }
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
                
                //var id = weatherJson["id"].int
                var cityName = weatherJson["name"].string
                var country = weatherJson["sys", "country"].string
                var sunRise = weatherJson["sys", "sunrise"].double
                var sunSet = weatherJson["sys", "sunset"].double
                var temperature = weatherJson["main", "temp"].double
                var minTemperature = weatherJson["main", "temp_min"].double
                var maxTemperature = weatherJson["main", "temp_max"].double
                var description = weatherJson["weather"][0]["description"].stringValue
                var pressure = weatherJson["main", "pressure"].int
                var humidity = weatherJson["main", "humidity"].int
               // var visibility = weatherJson["visibility"].int
                var wind = weatherJson["wind", "speed"].double
                var clouds = weatherJson["clouds", "all"].int
                var infoImage = weatherJson["weather"][0]["icon"].stringValue

                
                self.weather = Weather(name: cityName!, temp: temperature!, desc: description, coun: country!, minT: minTemperature!, maxT: maxTemperature!, sunR: sunRise!, sunS: sunSet!, pres: pressure!, humi: humidity!, wind: wind!, clou:clouds!, img: infoImage)

                self.setLabels()
            }
        }
    }
    
    /*
    *   Seting weather values get from class Weather.swift, to labels in storyboard.
    */
    func setLabels() {
        //Name of city
        if let name = self.weather?.name{
            self.townLabel.text = name
        }
        //Cloudy, sunny etc.
        if let country = self.weather?.coun{
            self.countryLabel.text = country
        }
        
        if let description = self.weather?.desc{
            self.descriptionLabel.text = description
        }
        
        if let minTemperature = self.weather?.minT{
            let celsiusTemp = ((minTemperature - 273.15))
            let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
            let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
            self.minTempLabel.text = myStringRoundedCelsiusTemp + ("°C")
        }
        
        if let maxTemperature = self.weather?.maxT{
            let celsiusTemp = ((maxTemperature - 273.15))
            let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
            let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
            self.maxTempLabel.text = myStringRoundedCelsiusTemp + ("°C")
        }
        
        //Temperature in city
        if let temp = self.weather?.temp{
            let celsiusTemp = ((temp - 273.15))
            let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
            let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
            self.temperatureLabel.text = myStringRoundedCelsiusTemp + ("°C")
        }
        
        if let sunRise = self.weather?.sunR{
            self.sunRiseLabel.text = stringFromTimeInterval(sunRise)
        }
        if let sunSet = self.weather?.sunS{
            self.sunSetLabel.text = stringFromTimeInterval(sunSet)
        }
        if let pressure = self.weather?.pres{
            self.pressurelabel.text = ("\(pressure) kPa")
        }
        if let humidity = self.weather?.humi{
            self.humidityLabel.text = ("\(humidity) %")
        }
        if let wind = self.weather?.wind {
            self.windLabel.text = ("\(wind) km/h")
        }
        if let clouds = self.weather?.clou{
            self.cloudsLabel.text = ("\(clouds) %")
        }
        if let img = self.weather?.img{
            
            statusImageView.image = UIImage(named: img)
        }
        
        
    }
    
    /*
    *   Store current location of device, then make and call ulr with position details. Then stop update location.
    */
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?lat=" + "\(locValue.latitude)" + "&lon=" + "\(locValue.longitude)")
        self.locationManager.stopUpdatingLocation()
    }
    
    /*
     *   handler for err
     */
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("ERR " + error.localizedDescription)
        //dopsat handler
    }
    
    /*
    *   TimeStamp value will be converted to format (hour:minute)
    */
    func stringFromTimeInterval(timeStamp:NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let hoursAndMinutes: String = "\(hour):\(minutes)"
        return hoursAndMinutes
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destViewController: LocationViewController = segue.destinationViewController as! LocationViewController
        destViewController.data =
    }
    */
}

