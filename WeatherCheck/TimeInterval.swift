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
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let hoursAndMinutes: String = "\(hour):\(minutes)"
        return hoursAndMinutes
    }
}