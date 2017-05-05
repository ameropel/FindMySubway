//
//  SelectionButton.swift
//  Find My Subway
//
//  Created by Mike Lepore on 5/3/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

@IBDesignable
class SelectionButton: UIView {
    
    var selectedButtonIndex: Int = 0
    private var buttons = [UIButton]()
    
    @IBInspectable var numOfButtons: Int = 2
    @IBInspectable var bufferSize: CGFloat = 12.0
    @IBInspectable var middleBuffer: CGFloat = 2.0
    @IBInspectable var cornerRadius: CGFloat = 2.0

    
    // MARK: - Initializer
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        
    }
    
    /*
    init?(withButtonTitles titles: [String]){
        super.init(frame: CGRect())
        
        self.numOfButtons = titles.count
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupUI()
    }
    
    
    // MARK: - UI
    
    private func setupUI() {
        
        self.setupButtonLayout()
        self.updateButtonColors()
    }
    
    private func setupButtonLayout() {
        
        // Get frame size for buttons
        var buttonSize = self.frame.width / CGFloat(integerLiteral: self.numOfButtons) // Get the inital frame size
        buttonSize -= self.bufferSize  // Remove outside buffers
        buttonSize -= self.middleBuffer / CGFloat(integerLiteral: self.numOfButtons) // Remove middle buffer

        var buttonIndex: Int = 0
        for _ in (0..<self.numOfButtons) {
            
            let button = UIButton()
            
            // Set frame size for button
            let indexFloatVal = CGFloat(integerLiteral: buttonIndex)
            let buttonX: CGFloat = self.bufferSize + (buttonSize * indexFloatVal) + (self.middleBuffer * indexFloatVal)
            button.frame = CGRect(x: buttonX, y: 0, width: buttonSize, height: self.frame.height)
            
            // Round corners of view
            if buttonIndex == 0 {
                button.roundCorners(corners: [.topLeft, .bottomLeft], withRadius: self.cornerRadius)
            } else if  buttonIndex == (self.numOfButtons - 1) {
                button.roundCorners(corners: [.topRight, .bottomRight], withRadius: self.cornerRadius)
            }
            
            self.addSubview(button)
            self.buttons.append(button)
            
            buttonIndex += 1
        }
    }

    private func updateButtonColors() {
        
        let offColor = StyleKit.ColorPalette.main.withAlphaComponent(0.7)
        let onColor  = StyleKit.ColorPalette.main
        
        var buttonIndex: Int = 0
        for button in buttons {
            button.backgroundColor = (buttonIndex == self.selectedButtonIndex) ? onColor : offColor
            buttonIndex += 1
        }
    }
}
