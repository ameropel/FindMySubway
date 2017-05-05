//
//  ImportDataManager.swift
//  Find My Subway
//
//  Created by Mike Lepore on 5/4/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import AEXML


class ImportDataManager: NSObject {

    static let shared: ImportDataManager = {
        let instance = ImportDataManager()
        return instance
    }()
    
    
    // MARK: - Helper Data Model
    
    struct SubwayData {
// Station ID,Complex ID,GTFS Stop ID,Division,Line,Stop Name,Borough,Daytime Routes,Structure,GTFS Latitude,GTFS Longitude
        
        let stationID: Int!
        let complexID: Int!
        let stopID: Int!
        let division: String
        let line: String
        let stopName: String
        let borough: String
        let daytimeRoutes: [String]
        let structures: String
        let latitude: String
        let longitude: String
        
        init(withDataString data: String) {
         
            let data = data.components(separatedBy: ",")
            
            self.stationID = Int(data[0])
            self.complexID = Int(data[1])
            self.stopID = Int(data[2])
            self.division = data[3]
            self.line = data[4]
            self.stopName = data[5]
            self.borough = data[6]
            self.daytimeRoutes = data[7].components(separatedBy: " ")
            self.structures = data[8]
            self.latitude = data[9]
            self.longitude = data[10]
        }
    }
    
    
    // MARK: - Writing Data
    
    private func readSubwayTextFile() {
        
        // Add the text file into project
        // SNew data should be located at http://web.mta.info/developers/data/nyct/subway/Stations.csv
        if let path = Bundle.main.path(forResource: "Stations", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                
                for text in myStrings {
                    
                }
                
            } catch {
                print(error)
            }
        }
        
    }
    
    func createData() {
        
        self.readSubwayTextFile()
        
        return
        
        let request =  AEXMLDocument()
        let dataMain = request.addChild(name: "Subway Station Data", attributes: ["site" : "http://web.mta.info/developers/data/nyct/subway/Stations.csv", "lastUpdate" : "######## DATE ########"])
        
        
        // Station ID,Complex ID,GTFS Stop ID,Division,Line,Stop Name,Borough,Daytime Routes,Structure,GTFS Latitude,GTFS Longitude
        
        let stationLine = dataMain.addChild(name: "Station", value: "")
        stationLine.addChild(name: "Station ID", value: "")
        stationLine.addChild(name: "Complex ID", value: "")
        stationLine.addChild(name: "GTFS Stop ID", value: "")
        stationLine.addChild(name: "Division", value: "")
        stationLine.addChild(name: "Line", value: "")
        stationLine.addChild(name: "Stop Name", value: "")
        stationLine.addChild(name: "Borough", value: "")
        stationLine.addChild(name: "Daytime Routes", value: "")
        stationLine.addChild(name: "Structure", value: "")
        stationLine.addChild(name: "GTFS Latitude", value: "")
        stationLine.addChild(name: "GTFS Longitude", value: "")
        
        print(request.xml)
    }
    
    private func createSubwayData(element: AEXMLElement) {
        
        let stationLine = element.addChild(name: "Station", value: "")
        stationLine.addChild(name: "Station ID", value: "")
        stationLine.addChild(name: "Complex ID", value: "")
        stationLine.addChild(name: "GTFS Stop ID", value: "")
        stationLine.addChild(name: "Division", value: "")
        stationLine.addChild(name: "Line", value: "")
        stationLine.addChild(name: "Stop Name", value: "")
        stationLine.addChild(name: "Borough", value: "")
        stationLine.addChild(name: "Daytime Routes", value: "")
        stationLine.addChild(name: "Structure", value: "")
        stationLine.addChild(name: "GTFS Latitude", value: "")
        stationLine.addChild(name: "GTFS Longitude", value: "")
    }

    
    // MARK: - Test Data
    
    func createTestXML() {
        
        let soapRequest =  AEXMLDocument()
        let attributes = ["xmlns:xsi" : "http://www.w3.org/2001/XMLSchema-instance", "xmlns:xsd" : "http://www.w3.org/2001/XMLSchema"]
        let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: attributes)
        let header = envelope.addChild(name: "soap:Header")
        let body = envelope.addChild(name: "soap:Body")
        
        header.addChild(name: "mTrans", value: "234", attributes: ["xmlns:m" : "http://www.w3schools.com/transaction/", "soap:mustUnderstand" : "1"])
        let getStockPrice = body.addChild(name: "m:GetStockPrice")
        getStockPrice.addChild(name: "m:SycokName", value: "AAPL")
        
        print(soapRequest.xml)
    }

}
