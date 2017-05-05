//
//  StationListSubwayView.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/25/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

class StationListSubwayView: UIView {
    
    let iconSize: Int = 20
    let iconBuffer: Int = 5
    var subwayData: SubwayStationData!
    
     // MARK: - Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - UI
    
    func configureWithData(data: SubwayStationData) {
        
        self.subwayData = data
        self.frame = self.viewSize()
        
        self.addSubwayLines()
    }
    
    private func viewSize() -> CGRect {
        let lineCount: Int = self.subwayData.lines.count
        
        let width: Int = (lineCount * self.iconSize) + (lineCount * self.iconBuffer)
        let height: Int = iconSize

        return CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func addSubwayLines() {
        
        // Remove all previous image views
        self.subviews.forEach({ $0.removeFromSuperview() })
        
        var index: Int = 0
        for line in self.subwayData.lines {
            
            let subwayIcon: UIImageView = UIImageView(image: UIImage(named: line.icon))
            let x: Int = (index * self.iconSize) + (index * self.iconBuffer)
            subwayIcon.frame = CGRect(x: x, y: 0, width: self.iconSize, height: self.iconSize)
            self.addSubview(subwayIcon)
            index += 1
        }
    }

}
