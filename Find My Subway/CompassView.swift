//
//  CompassView.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/23/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

@IBDesignable
class CompassView: UIView {
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    
    // MARK: - UI Setup
    
    private func setupUI() {
        
        self.backgroundColor = .clear
        
        // Setup compass image
        self.addCompassImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(compassHeadingUpdated), name: Constants().Notification_CompassHeadingUpdate, object: nil)
    }
    
    private func addCompassImage() {
    
        let imageView = UIImageView(image: UIImage(named: "test_compass"))
        imageView.frame = self.bounds
        self.addSubview(imageView)
    }
    
    @objc private func compassHeadingUpdated() {
        
        let tr = CGAffineTransform.identity.rotated(by: LocationManager.shared.compassHeadingRadians)
        self.transform = tr
    }

}
