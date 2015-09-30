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
    
    let locationManager = CLLocationManager()
    var locValue = CLLocationCoordinate2D()
    
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
       func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation], completionHandler: (Double?, Double) -> ()) {
        
         locValue = manager.location!.coordinate
        let long: Double = locValue.longitude
        let lati: Double = locValue.latitude
        
        print("\(locValue.latitude)" + "\(locValue.longitude)")
        
        completionHandler(long, lati)
        
    }
    /*
    *   Location was interupted or err occured. Get Linz weather instead.
    */
     @objc internal func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print("Nastala chyba v Location Manager: + \(error)", terminator: "")
        
    }
    
}