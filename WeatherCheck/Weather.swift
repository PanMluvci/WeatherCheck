//
//  Weather.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 12.07.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation

class Weather: NSObject {

    var name: String
    var temp: Double
    var desc: String
    var coun: String
    var minT: Double
    var maxT: Double
    var sunR: Double
    var sunS: Double
    var pres: Int
    var humi: Int
    var wind: Double
    var clou: Int
    var img: String
    
    init(name: String, temp: Double, desc: String, coun: String, minT: Double, maxT: Double, sunR: Double, sunS: Double, pres: Int, humi: Int, wind: Double, clou: Int, img:String){
        self.name = name
        self.temp = temp
        self.desc = desc
        self.coun = coun
        self.minT = minT
        self.maxT = maxT
        self.sunR = sunR
        self.sunS = sunS
        self.pres = pres
        self.humi = humi
        self.wind = wind
        self.clou = clou
        self.img = img
        
        super.init()
    }
}