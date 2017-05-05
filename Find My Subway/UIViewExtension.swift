//
//  UIViewExtension.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/23/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    // MARK: - Blur
    
    func addBlurView(blurStyle: UIBlurEffectStyle) {
        
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    func addBlurView(blurStyle: UIBlurEffectStyle, withVibrancyOnView view: UIView ) {
        
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        vibrancyView.contentView.addSubview(view)
        blurEffectView.contentView.addSubview(vibrancyView)
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    
    // MARK: - Round Corners
    
    func roundCorners(corners: UIRectCorner, withRadius radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height:  radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
