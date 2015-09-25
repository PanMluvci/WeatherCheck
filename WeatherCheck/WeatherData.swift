//
//  WeatherData.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 14.09.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherData: NSObject {

    var weather: Weather?
    var cityNameX = String()
    var countryX = String()
    /*
    func getWeatherData(urlString: String) -> (cityNameX: String, countryX: String) {
        

        
        Alamofire.request(.GET, urlString, parameters: nil) .responseJSON { (req, res, json, error) in
            
            if(error != nil) {
                return
            } else {
                
                /*for (key: String, subJson: JSON) in weatherJson {
                unfinished forecast iteration
                
                
                }*/
                //mohou byt let
                
                var weatherJson = JSON(json!)
                
                var cityName = weatherJson["name"].string
                self.cityNameX = cityName!
                var country = weatherJson["sys", "country"].string
                self.countryX = country!
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
                print("\(cityName)")
                self.weather = Weather(name: cityName!, temp: temperature!, desc: description, coun: country!, minT: minTemperature!, maxT: maxTemperature!, sunR: sunRise!, sunS: sunSet!, pres: pressure!, humi: humidity!, wind: wind!, clou:clouds!, img: infoImage)
               //vola se metoda kam se ty promene ulozí a zobrazí v labelech
                print("\(self.weather?.name)")
                
                
            }
        }
        print("\(cityNameX) dasdsadas")
        return (cityNameX,countryX)
        
    }*/
}