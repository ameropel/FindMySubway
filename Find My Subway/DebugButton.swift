//
//  DebugButton.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/22/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

class DebugButton: UIButton {

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
        
        #if DEBUG
            self.isHidden = false
            self.backgroundColor = .clear
            var image = UIImage(named: "test_debug")
            image = image?.maskWithColor(color: StyleKit.ColorPalette.main)
            self.setImage(image, for: .normal)
            
            self.isUserInteractionEnabled = true
            addTarget(self, action: #selector(debugButtonPressed), for: .touchUpInside)
        #else
            self.isHidden = true
        #endif
    }
    

    // MARK: - IBActions
    
    @objc fileprivate func debugButtonPressed() {
        
        let topVC   = Utils.topViewController()
        let debugVC = DebugViewController()
        debugVC.modalPresentationStyle = .custom
        debugVC.modalTransitionStyle = .crossDissolve
        topVC.present(debugVC, animated: true, completion: nil)
    }
}
