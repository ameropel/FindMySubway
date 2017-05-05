//
//  MainViewController.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/28/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var scene: SceneView!
    private let camera = CameraController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        // Navifation
        SPOTIFY()
        
        // Camera
        self.camera.initCamera(inContainer: self.view)
        
        // Scene
        self.view.bringSubview(toFront: self.scene)
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.camera.layoutPreviewLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func SPOTIFY() {
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .black
        settings.style.buttonBarItemBackgroundColor = .black
        settings.style.selectedBarBackgroundColor = StyleKit.ColorPalette.main
        settings.style.buttonBarItemFont = StyleKit.Typography.titleStyle
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        
        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 144/255.0, alpha: 1.0)
            newCell?.label.textColor = .white
        }
    }
    
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let controller_1 = SelectStationViewController(itemInfo: IndicatorInfo(title: "FILTER"))
        let controller_2 = NavigationViewController(itemInfo: IndicatorInfo(title: "NAVIGATE"))
        
        return [controller_2, controller_1]
    }
}
