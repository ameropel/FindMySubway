//
//  FilterStationsCollection.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/25/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

protocol FilterStationsDelegate : class {
    func filteredStationLines(lines: [SubwayStationHelper.StationLineType])
}

class FilterStationsCollection: UICollectionViewController {
    
    private var tableData: [SubwayStationHelper.StationLineType] = []
    private var filterLines: [SubwayStationHelper.StationLineType] = []
    weak var delegate: FilterStationsDelegate?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableData = SubwayStationHelper().listOfSubwayLines()
        
        self.collectionView?.delegate   = self
        self.collectionView?.dataSource = self
        
        self.collectionView?.showsHorizontalScrollIndicator = false
        
        // Configure Cells
        self.collectionView?.register(UINib(nibName: "FilterStationsCell", bundle: nil), forCellWithReuseIdentifier: "FilterStationsCell")
    }

    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tableData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterStationsCell", for: indexPath) as! FilterStationsCell
        
        let data = self.tableData[(indexPath as NSIndexPath).row]
        cell.setCellData(line: data, isFiltered: self.filterLines.contains(data))
        
        return cell
    }
    

    // MARK: UICollectionViewDelegate

    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = self.tableData[(indexPath as NSIndexPath).row]
        
        if self.filterLines.contains(data) {
            self.filterLines.remove(at: self.filterLines.index(of: data)!)
        } else {
            self.filterLines.append(data)
        }
        
        collectionView.reloadItems(at: [indexPath])
        
        self.delegate?.filteredStationLines(lines: self.filterLines)
    }
}
