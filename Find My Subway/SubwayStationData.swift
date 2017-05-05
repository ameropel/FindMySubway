//
//  SubwayStationData.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/24/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import CoreLocation
import AEXML
import SceneKit

class SubwayStationData: NSObject {
    
    var name: String! = ""
    var coordinates = CLLocation()
    var lines: [StationLine] = []
    var stationNode: SCNNode!
    
    struct StationLine {
        var name: String!
        var type: SubwayStationHelper.StationLineType
        var icon: String!
    }
    
    init?(data: AEXMLElement) {
        
        super.init()
        
        let nameString = (data["station_name"].value ?? "").isEmpty ? "Unnown" : data["station_name"].value!
        let latString  = (data["latitude"].value ?? "").isEmpty ? "0.0" : data["latitude"].value!
        let longString = (data["longitude"].value ?? "").isEmpty ? "0.0" : data["longitude"].value!
        let lineString = (data["line"].value ?? "").isEmpty ? "" : data["line"].value!
        
        self.name = nameString
        self.coordinates = CLLocation(latitude: Double(latString)!, longitude: Double(longString)!)
        self.setSubwayLines(data: lineString)
    }
    
    
    // MARK: - Station Lines
    
    private func setSubwayLines(data: String) {
        
        let stationNames = data.components(separatedBy: "-")
        
        for station in stationNames {
            
            let type = SubwayStationHelper().getSubwayLineEnum(line: station)
            let icon = SubwayStationHelper().getSubwayLineIcon(line: type)
            
            let line = StationLine(name: station, type: type, icon: icon)
            self.lines.append(line)
        }
    }
    
    
    // MARK: - Distance
    
    func distanceFromUserInMiles() -> Double {
    
        return Utils.calculateDistance(locationOne: LocationManager.shared.getUserLocation().coordinate, locationTwo: self.coordinates.coordinate)
    }
    
    
    // MARK: - Contains Line
    
    func containsSubwayLine(lines: [SubwayStationHelper.StationLineType]) -> Bool {
        var contains = false
        for line in lines {
            if (self.lines.contains { $0.type == line } ) {
                contains = true
                break
            }
        }
        return contains
    }
    
    func containsSubwayLine(line: SubwayStationHelper.StationLineType) -> Bool {
        return self.lines.contains { $0.type == line }
    }
    
    
    // MARK: - Station Node
    
    func initializeNode(inWorld world: SCNNode) {
        
        // Create a cube and place it in the scene
        let station = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 0)
        station.firstMaterial?.diffuse.contents = UIColor(red: 0.149, green: 0.604, blue: 0.859, alpha: 1.0)
        self.stationNode = SCNNode(geometry: station)
        
        self.stationNode.position = Utils.realWorldCoordsToWorldCoords(location: self.coordinates.coordinate)
        
        let stationText = SCNText(string: self.name, extrusionDepth: 2)
        stationText.font = UIFont(name: "Optima", size: 4)
        let stationTextNode = SCNNode(geometry: stationText)
        let textXPosition = (abs(stationText.boundingBox.min.x) + abs(stationText.boundingBox.max.x)) / 2
        
        stationTextNode.position = SCNVector3(x: textXPosition, y: 3, z: 0)
        stationTextNode.constraints = [SCNBillboardConstraint()]
        self.stationNode.addChildNode(stationTextNode)
        
        world.addChildNode(self.stationNode)
    }
}
