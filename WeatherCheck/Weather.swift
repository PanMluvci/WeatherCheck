//
//  Weather.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 12.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation

class Weather: NSObject {
    var id: Int
    var name: String
    var temp: Double
    var desc: String
    var coun: String
    var minT: Double
    var maxT: Double
    var sunR: Double
    var sunS: Double
    
    
    init(id: Int, name:String, temp:Double, desc: String, coun: String, minT:Double, maxT:Double, sunR: Double, sunS: Double ){
        self.id = id
        self.name = name
        self.temp = temp
        self.desc = desc
        self.coun = coun
        self.minT = minT
        self.maxT = maxT
        self.sunR = sunR
        self.sunS = sunS
        
        super.init()
    }
}