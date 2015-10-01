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
    var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override init(){
        super.init()
        
        setupLocationManager()
    }

    /*
    *   Store current location of device, then make and call ulr with position details. Then stop update location.
    */
      @objc internal func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locValue = manager.location!.coordinate
        print("\(locValue.latitude)" + "\(locValue.longitude)")
        
    }
    /*
    *   Location was interupted or err occured. Get Linz weather instead.
    */
      @objc internal func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print("Nastala chyba v Location Manager: + \(error)", terminator: "")
        
    }
    func getLocation() -> (Double){
        return locValue.latitude
    }
    
     private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways{
            
            locationManager.startUpdatingLocation()
            
        }else{
            locationManager.requestWhenInUseAuthorization()
            
        }
    }
    
    @objc internal func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.AuthorizedWhenInUse || status == CLAuthorizationStatus.AuthorizedAlways {
            
            locationManager.startUpdatingLocation()
            
        }
    }
    
}