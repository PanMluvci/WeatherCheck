//
//  TimeInterval.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 13.09.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation

class TimeInterval {
    /*
    *   TimeStamp value will be converted to format (hour:minute)
    */
    func stringFromTimeInterval(timeStamp:NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let hoursAndMinutes: String = "\(hour):\(minutes)"
        return hoursAndMinutes
    }
    
    /*
    *   Give me your temperature and I round and convert it to the Celsius. Then change type from Double to String and Return it
    .
    */
    func roundTemperature(temp: Double) -> String {
        let celsiusTemp = ((temp - 273.15))
        let roundCelsiusTemp = Int(round(10*celsiusTemp)/10)
        let myStringRoundedCelsiusTemp = roundCelsiusTemp.description
        return myStringRoundedCelsiusTemp + ("°C")
    }
}