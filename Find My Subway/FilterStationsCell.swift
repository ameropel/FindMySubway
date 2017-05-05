//
//  FilterStationsCell.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/25/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

class FilterStationsCell: UICollectionViewCell {

    @IBOutlet weak var stationIcon: UIImageView!
    private var line: SubwayStationHelper.StationLineType!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellData(line: SubwayStationHelper.StationLineType, isFiltered filtered: Bool) {
        self.line = line
        
        self.stationIcon.alpha = filtered ? 1 : 0.5
        self.stationIcon.image = UIImage(named: SubwayStationHelper().getSubwayLineIcon(line: self.line))
    }

}
