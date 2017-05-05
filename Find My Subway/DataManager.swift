//
//  DataManager.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/24/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import AEXML
import CoreLocation

class DataManager: NSObject {
    
    private var subwayData: [SubwayStationData] = []
    var averageSubwayCoordinate: CLLocation = CLLocation()
    
    static let shared: DataManager = {
        let instance = DataManager()
        return instance
    }()
    
    
    // MARK: - Loading Data
    
    func importSubwayData() {
        
        guard subwayData.isEmpty else { return }
        
        let subwayDataFileName: String = "XMLData"
        
        guard let xmlPath = Bundle.main.path(forResource: subwayDataFileName, ofType: "xml"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
        else {
            print("%@ could not be found", subwayDataFileName)
            return
        }
        
        var options = AEXMLOptions()
        options.parserSettings.shouldResolveExternalEntities = true
        
        do {
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            
            // Prints the same XML structure as original
            //print(xmlDoc.xml)
        
            var averageLat = 0.0
            var averageLong = 0.0
            var averageIndex = 0.0
            
            if let subwayStations = xmlDoc.root["subway_stations"]["station"].all {
                for subway in subwayStations {
                    
                    if let data = SubwayStationData.init(data: subway) {
                        self.subwayData.append(data)
                        
                        averageLat += data.coordinates.coordinate.latitude
                        averageLong += data.coordinates.coordinate.longitude
                        averageIndex += 1
                    }
                }
            }
            
            // Get the average location, this will be used as our maps center point
            self.averageSubwayCoordinate = CLLocation(latitude: averageLat/averageIndex, longitude: averageLong/averageIndex)
            
            DispatchQueue.global(qos: .background).async {
                self.subwayData.sort { $0.name < $1.name }
                NotificationCenter.default.post(name: Constants().Notification_DataLoaded, object: nil)
            }
            
        } catch {
            
        }
    }
    
    
    // MARK: - Subway Data
    
    func retrieveAllSubwayData() -> [SubwayStationData] {
        return self.subwayData
    }
    
    func retrieveFilteredSubwayLinesData(lines: [SubwayStationHelper.StationLineType]) -> [SubwayStationData] {
        
        var data: [SubwayStationData] = []
            
        for subway in self.subwayData {
            if subway.containsSubwayLine(lines: lines) {
                data.append(subway)
            }
        }
            
        return data
    }

}
