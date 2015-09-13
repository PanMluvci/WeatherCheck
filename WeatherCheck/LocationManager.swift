//
//  LocationManager.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 10.09.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//
//
//  This Class using CoreLocation library for showing current position of device.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var locValue = CLLocationCoordinate2D()
    
    private var errorFound : Bool = false
    
    override init(){
        super.init()
        
        self.locationManager.startUpdatingLocation()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        
    }

    /*
    *   Store current location of device, then make and call ulr with position details. Then stop update location.
    */
    private func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
         locValue = manager.location.coordinate
       // getWeatherData("http://api.openweathermap.org/data/2.5/weather?lat=" + "\(locValue.latitude)" + "&lon=" + "\(locValue.longitude)")
        
        println("Latitude: \(locValue.latitude) Longtitude: \(locValue.longitude)")
    }
    
    /*
    *   Location was interupted or err occured. Get Linz weather instead.
    */
    private func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        if ((error) != nil) {
            if (errorFound == false) {
                errorFound = true
                print("Nastala chyba + \(error)")
            }
        }else{
            //getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Linz")
        }
        
        
    }
    
}