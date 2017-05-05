//
//  AppDelegate.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/22/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import Foundation
import UIKit

class StyleKit: NSObject {
    
    // MARK: Colors
    
    internal enum ColorPalette {
        
        static let main = StyleKit.color(fromHex: 0x009688)
        static let mainLight = StyleKit.color(fromHex: 0x4DB6AC)
        static let mainDark = StyleKit.color(fromHex: 0x00796B)
        static let secondary = StyleKit.color(fromHex: 0xFFC107)
        static let secondaryLight = StyleKit.color(fromHex: 0xFFD54F)
        static let secondaryDark = StyleKit.color(fromHex: 0xFFA000)
    }
    
    internal enum ColorPalette_Subway {
        
        static let line_ACE = StyleKit.color(fromHex: 0x0039A6)
        static let line_BDFM = StyleKit.color(fromHex: 0xFF6319)
        static let line_G = StyleKit.color(fromHex: 0x6CBE45)
        static let line_JZ = StyleKit.color(fromHex: 0x996633)
        static let line_L = StyleKit.color(fromHex: 0xA7A9AC)
        static let line_NQR = StyleKit.color(fromHex: 0xFCCC0A)
        static let line_S = StyleKit.color(fromHex: 0x808183)
        static let line_123 = StyleKit.color(fromHex: 0xEE352E)
        static let line_456 = StyleKit.color(fromHex: 0x00933C)
        static let line_7 = StyleKit.color(fromHex: 0xB933AD)
    }

    static func color(fromHex hex:Int) -> UIColor {
        return color(fromHex: hex, alpha: 1.0)
    }
    
    static func color(fromHex hex:Int, alpha: CGFloat) -> UIColor {
        
        let redComponent = CGFloat((hex >> 16 & 0xFF)) / 255.0
        let greenComponent = CGFloat((hex >> 8 & 0xFF)) / 255.0
        let blueComponent = CGFloat((hex & 0xFF)) / 255.0
        return UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: alpha)
    }
    
    internal static func black(withAlpha alpha: CGFloat) -> UIColor {
        return color(fromHex: 0x000000, alpha: alpha)
    }
    
    internal static func white(withAlpha alpha: CGFloat) -> UIColor {
        return color(fromHex: 0xFFFFFF, alpha: alpha)
    }
    
    
    // MARK: Typography
    
    enum Font: String {
        
        case sanFranciscoDisplayLight    = "SanFranciscoDisplay-Light"
        case sanFranciscoDisplayRegular  = "SanFranciscoDisplay-Regular"
        case sanFranciscoDisplaySemibold = "SanFranciscoDisplay-Semibold "
    }
    
    internal enum Typography {
        
        static let bodyStyle = UIFont(name: Font.sanFranciscoDisplayRegular.rawValue, size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        static let titleStyle = UIFont(name: Font.sanFranciscoDisplaySemibold.rawValue, size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        
        static func light(size:CGFloat) -> UIFont {
            
            if let font = UIFont(name: Font.sanFranciscoDisplayLight.rawValue, size: size) {
                return font
            } else {
                return UIFont.systemFont(ofSize: size)
            }
        }
        
        static func normal(size:CGFloat) -> UIFont {
            
            if let font = UIFont(name: Font.sanFranciscoDisplayRegular.rawValue, size: size) {
                return font
            } else {
                return UIFont.systemFont(ofSize: size)
            }
        }
        
        static func bold(size:CGFloat) -> UIFont {
            
            if let font = UIFont(name: Font.sanFranciscoDisplaySemibold.rawValue, size: size) {
                return font
            } else {
                return UIFont.boldSystemFont(ofSize: size)
            }
        }
    }
}
