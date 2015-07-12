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
    
    init(id: Int, name:String, temp:Double, desc: String){
        self.id = id
        self.name = name
        self.temp = temp
        self.desc = desc
        super.init()
    }
}