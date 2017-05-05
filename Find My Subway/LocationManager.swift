//
//  LocationManager.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/6/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import CoreLocation

final class LocationManager: NSObject {
    
    let initalMapLocation = CLLocation(latitude: 40.750580, longitude: -73.993584)   // Inital location is Penn Station
    var compassHeadingRadians: CGFloat = 0
    private var locationManager: CLLocationManager!
    fileprivate var userCoordinates: CLLocation!
    
    static let shared: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    func initialize() {
        guard self.locationManager == nil else { return }
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingHeading()
        
        // Ask for location
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.startUpdatingLocation()
    }
    
    fileprivate func formattedCoordinates() -> String {
        
        guard (self.userCoordinates != nil) else { return "-" }
        
        let lat : Float = Float(self.userCoordinates.coordinate.latitude)
        let long : Float = Float(self.userCoordinates.coordinate.longitude)
        
        return String(format: "%0.2f, %0.2f", lat, long)
    }
    
    func getUserLocation() -> CLLocation {
        
        return (DebugManager.shared.isDebugLocationActive) ? DebugManager.shared.userCoordinates : self.userCoordinates
    }
}


// MARK: - EXTENSION: CLLocationManagerDelegate

extension LocationManager : CLLocationManagerDelegate {
    
    // Compass
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        let angle = -(newHeading.magneticHeading)
        let radians = (angle) * .pi / 180
        self.compassHeadingRadians = CGFloat(radians)
        NotificationCenter.default.post(name: Constants().Notification_CompassHeadingUpdate, object: nil)
    }
    
    // Longitude Latitude
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get the last location recorded
        guard locations.count > 0 else { return }
        self.userCoordinates = locations.last
        
        //NSLog("GPS Location: %@", self.formattedCoordinates())
    }
}
