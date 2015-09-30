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
    
    func getWeatherData(urlString: String, completionHandler: (String?) -> ()) -> (){
        
        
        Alamofire.request(.GET, urlString, parameters: nil, encoding: ParameterEncoding.URL).responseJSON { (_, _, result) in
            switch result {
                    
                case .Success(let data):

                    let weatherJson = JSON(data)
                    
                    let cityName = weatherJson["name"].string
                    
                    let country = weatherJson["sys", "country"].string
                    let sunRise = weatherJson["sys", "sunrise"].double
                    let sunSet = weatherJson["sys", "sunset"].double
                    let temperature = weatherJson["main", "temp"].double
                    let minTemperature = weatherJson["main", "temp_min"].double
                    let maxTemperature = weatherJson["main", "temp_max"].double
                    let description = weatherJson["weather"][0]["description"].stringValue
                    let pressure = weatherJson["main", "pressure"].int
                    let humidity = weatherJson["main", "humidity"].int
                    let wind = weatherJson["wind", "speed"].double
                    let clouds = weatherJson["clouds", "all"].int
                    let infoImage = weatherJson["weather"][0]["icon"].stringValue
                    
                    //self.weather = Weather(name: cityName!, temp: temperature!, desc: description, coun: country!, minT: minTemperature!, maxT: maxTemperature!, sunR: sunRise!, sunS: sunSet!, pres: pressure!, humi: humidity!, wind: wind!, clou:clouds!, img: infoImage)
                
                    completionHandler(cityName)
                
                case .Failure(_, let error):
                    print("ALAMOFIRE: Request failed with error: \(error)")
                     }
    }
                /*for (key: String, subJson: JSON) in weatherJson {
                unfinished forecast iteration
                */
    
    
    }
    
    
    func getData(urlString: String) -> (String){
        var cityNameX = String()
        getWeatherData(urlString) { (cityName) in
                print(urlString)
                print(cityName)
            cityNameX = cityName!
        }
        return cityNameX
    }
    
 }