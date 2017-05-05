//
//  NavigationViewController.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/29/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NavigationViewController: UIViewController, IndicatorInfoProvider {

    var itemInfo = IndicatorInfo(title: "View")
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
