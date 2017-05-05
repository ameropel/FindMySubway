//
//  StationListCell.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/25/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

class StationListCell: UITableViewCell {

    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var lineContainer: StationListSubwayView!
    @IBOutlet weak var stationDistance: UILabel!
    private var subwayData: SubwayStationData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
    }

    func setCellData(data: SubwayStationData) {
        
        self.subwayData = data
        self.stationName.text = self.subwayData.name
        self.lineContainer.configureWithData(data: self.subwayData)
        
        let distance: Double = self.subwayData.distanceFromUserInMiles()
    
        self.stationDistance.text = String(format: "%0.2f", distance)
    }
}
