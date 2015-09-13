//
//  ViewController.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 10.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    private var weather: Weather?
    private var locationManager: LocationManager?
    let timeInterval = TimeInterval()
    //private var locationManager = LocationManager()
    
     var passingData = String("")
    private var errorFound : Bool = false
     var auth = Bool(false)
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
    
    /*
    *   Navigate and open LocationViewController after pressing the button
    */
    @IBAction func navigationBtnToLocationVC(sender: AnyObject) {
        
        let openLocationVC = self.storyboard?.instantiateViewControllerWithIdentifier("LocationVC") as! SearchLocationViewController
        self.navigationController?.pushViewController(openLocationVC, animated: true)
    }
    
    /*
    *   Navigate and open StoredCityViewController after pressing the button
    */
    @IBAction func navigationBtnToStoredCityVC(sender: AnyObject) {
        
        let openStoredCityVC = self.storyboard?.instantiateViewControllerWithIdentifier("StoredCityVC") as! StoredCityPickerViewController
        self.navigationController?.pushViewController(openStoredCityVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchingForCity(passingData)
        buttonSkinView()
        
        self.locationManager = LocationManager()
        println(locationManager?.locValue.longitude)
        
        if auth == false{
            //CLLocationManagerDelegateauthFB()
            
        }
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    * Search for the city's weather status.
    * If no start value in searched city, use the current location.
    */
    func searchingForCity(data:String){
        if(passingData.isEmpty == false){
            getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(passingData)")
        }else{
            println("ELSE")
            //println("ALatitude: \(locationManager!.locValue.latitude) Longtitude: \(locationManager!.locValue.longitude)")
         
        }
    }
    /*
    *   Get all important current weather values.
    */
    func getWeatherData(urlString: String) {
        
        Alamofire.request(.GET, urlString, parameters: nil) .responseJSON { (req, res, json, error) in
            
            if(error != nil) {
                return
            } else {
    
            /*for (key: String, subJson: JSON) in weatherJson {
                unfinished forecast iteration
                
                
            }*/
                var weatherJson = JSON(json!)
                
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
                var wind = weatherJson["wind", "speed"].double
                var clouds = weatherJson["clouds", "all"].int
                var infoImage = weatherJson["weather"][0]["icon"].stringValue
                
                self.weather = Weather(name: cityName!, temp: temperature!, desc: description, coun: country!, minT: minTemperature!, maxT: maxTemperature!, sunR: sunRise!, sunS: sunSet!, pres: pressure!, humi: humidity!, wind: wind!, clou:clouds!, img: infoImage)

                self.setLabels()
            }
        }
    }
    
    /*
    *   Seting weather values get from class Weather.swift, to labels in storyboard. ZUSTANE
    */
    private func setLabels() {
        if let name = self.weather?.name{
            self.townLabel.text = name
        }
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
        if let temp = self.weather?.temp{
            let celsiusTemp = ((temp - 273.15))
            let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
            let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
            self.temperatureLabel.text = myStringRoundedCelsiusTemp + ("°C")
        }
        if let sunRise = self.weather?.sunR{
            self.sunRiseLabel.text = timeInterval.stringFromTimeInterval(sunRise)
        }
        if let sunSet = self.weather?.sunS{
            self.sunSetLabel.text = timeInterval.stringFromTimeInterval(sunSet)
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
    *   Add skins for buttons, background, scrollpanel
    */
    func buttonSkinView(){
        self.navigationController?.navigationBarHidden = true
        self.navigationController!.toolbar.barTintColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.layer.borderWidth = 0.5
        self.navigationController!.toolbar.layer.borderColor = UIColor.whiteColor().CGColor
       
        self.backgroundImageView.backgroundColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        
        srollingInfoLabel.contentSize.height = 300
        
        descriptionLabel.layer.borderWidth = 0.5
        descriptionLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
 
}

