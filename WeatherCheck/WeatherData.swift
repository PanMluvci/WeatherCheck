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
    
     func getWeatherData(urlString: String, completionHandler: (String, String, Double, Double, Double, Double, Double, String, Int, Int, Double, Int, String) -> ()) -> (){
        
        
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
                    
                    completionHandler(cityName!,country!,sunRise!, sunSet!, temperature!, minTemperature!, maxTemperature!, description, pressure!, humidity!, wind!, clouds!, infoImage)

                case .Failure(_, let error):
                    print("ALAMOFIRE: Request failed with error: \(error)")
                     }
            }
                /*for (key: String, subJson: JSON) in weatherJson {
                unfinished forecast iteration
                */
    
    }
    
 }