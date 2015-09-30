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
    
    var weather : Weather?
     private let timeInterval = TimeInterval()
     private let locationManager = LocationManager()
     private let weatherData = WeatherData()
    
     var passingData = String("")
     var errorFound : Bool = false
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
    @IBAction func switchToLocationVC(sender: AnyObject) {
        
        let openLocationVC = self.storyboard?.instantiateViewControllerWithIdentifier("LocationVC") as! SearchLocationViewController
        self.navigationController?.pushViewController(openLocationVC, animated: true)
    }
    
    /*
    *   Navigate and open StoredCityViewController after pressing the button
    */
    @IBAction func switchToStoredCityVC(sender: AnyObject) {
        
        let openStoredCityVC = self.storyboard?.instantiateViewControllerWithIdentifier("StoredCityVC") as! StoredCityPickerViewController
        self.navigationController?.pushViewController(openStoredCityVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Berlin")
         
       
        
        searchingForCity(passingData)
        buttonSkinView()
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
            print("SearchingForCity()ELSE")

         
        }
    }
    
    /*
    *   Get all important current weather values. MODEL
    */
    func getWeatherData(urlString: String) {
       
        weatherData.getWeatherData(urlString) { (cityName,country, sunRise, sunSet, temperature, minTemperature, maxTemperature, description, pressure, humidity, wind, clouds, infoImage)  in
                        
            self.weather = Weather(name: cityName, temp: temperature, desc: description, coun: country, minT: minTemperature, maxT: maxTemperature, sunR: sunRise, sunS: sunSet, pres: pressure, humi: humidity, wind: wind, clou:clouds, img: infoImage)
            
            self.setLabels()
        }
        
    }
    
    /*
    *   Seting weather values get from class Weather.swift, to labels in storyboard. 
    */
     func setLabels() {
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
            self.minTempLabel.text = timeInterval.roundTemperature(minTemperature)
        }
        if let maxTemperature = self.weather?.maxT{
            self.maxTempLabel.text = timeInterval.roundTemperature(maxTemperature)
        }
        if let temp = self.weather?.temp{
            self.temperatureLabel.text = timeInterval.roundTemperature(temp)
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
    private func buttonSkinView(){
        self.navigationController?.navigationBarHidden = true
        self.navigationController!.toolbar.barTintColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        self.navigationController!.toolbar.layer.borderWidth = 0.5
        self.navigationController!.toolbar.layer.borderColor = UIColor.whiteColor().CGColor
       
        self.backgroundImageView.backgroundColor = UIColor(red: 117/255, green:209/255, blue: 255/255, alpha: 1)
        
        //srollingInfoLabel.contentSize.height = 450
        
        descriptionLabel.layer.borderWidth = 0.5
        descriptionLabel.layer.borderColor = UIColor.whiteColor().CGColor

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
 
}

