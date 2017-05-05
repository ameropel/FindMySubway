//
//  Utils.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/23/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import SceneKit

class Utils {
 
    static func topViewController() -> UIViewController {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return UIViewController()
    }
    
    
    // MARK: - Distance and Coords
    
    static func calculateDistance(locationOne: CLLocationCoordinate2D, locationTwo: CLLocationCoordinate2D) -> Double {
        
        // Haversine formula (Optimized)
        // http://stackoverflow.com/questions/27928/calculate-distance-between-two-latitude-longitude-points-haversine-formula
        
        let p = 0.017453292519943295;    // Math.PI / 180
        let a = 0.5 - (cos((locationTwo.latitude - locationOne.latitude) * p))/2 +
            cos(locationOne.latitude * p) * cos(locationTwo.latitude * p) *
            (1 - cos((locationTwo.longitude - locationOne.longitude) * p))/2
        
        let km = 12742 * asin(sqrt(a)) // 2 * R; R = 6371 km
        return km * 0.621371 // Now in miles
    }
    
    static func calculateBearing(locationOne: CLLocationCoordinate2D, locationTwo: CLLocationCoordinate2D) -> Double {
        
        // https://danielsaidi.wordpress.com/2011/02/04/geo-location-in-c-calculate-distance-and-bearing-between-two-positions/
        
        let lat1 = Double(locationOne.latitude).degreesToRadians
        let lat2 = Double(locationTwo.latitude).degreesToRadians
        let long1 = Double(locationOne.longitude).degreesToRadians
        let long2 = Double(locationTwo.longitude).degreesToRadians
        let dLong = long2 - long1
        
        let y = sin(dLong) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLong)
        
        let bearing = atan2(y, x)
        let bearingToDegrees = bearing.radiansToDegrees
        let finalBearing = (bearingToDegrees + 360).truncatingRemainder(dividingBy:360)
        
        return finalBearing
    }
    
    /*
     // Distance between the average real world position and stations position
     float distance = CalculateDistance(Constants.averageRealWorldCoords, realWorldCoords);
     
     // Angle between the average real world position and stations position
     float angle = CalculateBearing(Constants.averageRealWorldCoords, realWorldCoords);
     
     // Get new coordinates
     float x = distance * Mathf.Cos(angle * Mathf.Deg2Rad);
     float y = distance * Mathf.Sin(angle * Mathf.Deg2Rad);
     
     // New location in map
     Vector2 newPosition = Constants.worldCenterPoint + new Vector2(x, y);
     
     return newPosition;
 */
    
    static func realWorldCoordsToWorldCoords(location: CLLocationCoordinate2D) -> SCNVector3 {
        
        // Distance between the average real world position and stations position
        let distance = Utils.calculateDistance(locationOne: DataManager.shared.averageSubwayCoordinate.coordinate, locationTwo: location)
        
        // Angle between the average real world position and stations position
        let angle = Utils.calculateBearing(locationOne: DataManager.shared.averageSubwayCoordinate.coordinate, locationTwo: location)
        
        // Get new coordinates
        let x = distance * cos(angle.degreesToRadians)
        let y = distance * sin(angle.degreesToRadians)
        
        // World coords
        return SCNVector3Make(Float(x), 0, Float(y))
    }
}


// MARK: - EXTENSION : Double

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
