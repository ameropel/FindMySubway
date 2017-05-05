//
//  StationListTable.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/25/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

class StationListTable: UITableViewController {
    
    private var tableData: [SubwayStationData] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = StyleKit.white(withAlpha: 0.65)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 58
        
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        
        // Remove empty cells dividers
        self.tableView.tableFooterView = UIView()
        
        // Configure Cells
        self.tableView.register(UINib(nibName: "StationListCell", bundle: nil), forCellReuseIdentifier: "StationListCell")
    }
    
    
    // MARK: - Helpers
    
    func refreshTable(withData data: [SubwayStationData]) {
        self.tableData.removeAll()
        self.tableData.append(contentsOf: data)
        self.tableView.reloadData()
        
        // Hide table if there is no data
        self.view.isHidden = tableData.count == 0 ? true : false
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationListCell", for: indexPath) as! StationListCell
        
        let subwayData = self.tableData[(indexPath as NSIndexPath).row]
        cell.setCellData(data: subwayData)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
