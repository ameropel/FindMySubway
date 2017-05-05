//
//  DebugManager.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/22/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import MapKit

class DebugManager {
    
    var userCoordinates = CLLocation(latitude: 40.750580, longitude: -73.993584)   // Inital location is Penn Station
    var isDebugLocationActive: Bool = false
    
    static let shared: DebugManager = {
        let instance = DebugManager()
        return instance
    }()
}
