//
//  SelectStationViewController.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/25/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SelectStationViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var stationFilterContainer: UIView!
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var emptyTableView: UIView!
    
    var itemInfo = IndicatorInfo(title: "View")
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy fileprivate(set) var tableView: StationListTable! = {
        var controller = StationListTable(nibName: "StationListTable", bundle: nil)
        return controller
    }()
    
    lazy fileprivate(set) var stationFilter: FilterStationsCollection! = {
        var controller = FilterStationsCollection(nibName: "FilterStationsCollection", bundle: nil)
        return controller
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBlurView(blurStyle: .dark)
        self.setupUI()
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.tableView != nil) {
            self.tableView.view.frame = self.tableContainer.bounds
        }
        
        if (self.stationFilter != nil) {
            self.stationFilter.view.frame = self.stationFilterContainer.bounds
        }
    }
    
    // MARK: - UI
    
    private func setupUI() {
        
        // Setup Filter
        self.stationFilter.view.frame = self.stationFilterContainer.bounds
        self.stationFilterContainer.addSubview(self.stationFilter.view)
        self.stationFilter.delegate = self
        
        // Setup Table
        self.tableView.view.frame = self.tableContainer.bounds
        self.tableContainer.addSubview(self.tableView.view)
        self.tableView.refreshTable(withData: DataManager.shared.retrieveFilteredSubwayLinesData(lines: []))
    }
    
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}


// MARK: - EXTENSION : FilterStationsDelegate

extension SelectStationViewController : FilterStationsDelegate {
    
    func filteredStationLines(lines: [SubwayStationHelper.StationLineType]) {
        self.tableView.refreshTable(withData: DataManager.shared.retrieveFilteredSubwayLinesData(lines: lines))
    }
}
