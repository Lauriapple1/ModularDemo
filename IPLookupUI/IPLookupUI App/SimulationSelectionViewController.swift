//
//  SimulationSelectionViewController.swift
//  IPLookupUI App
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import UIKit

class SimulationSelectionViewController: UITableViewController {
    enum CellID: String {
        case IPv4, IPv6, Timeout, Immediate, Alternating
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath),
            reuseIdentifier = cell.reuseIdentifier,
            selectedCellID = CellID(rawValue: reuseIdentifier) else {
                fatalError("No simulation selection for cell \(indexPath)")
        }
        
        switch selectedCellID {
        case .IPv4:
            setResultType(.IPv4)
            
        case .IPv6:
            setResultType(.IPv6)
            
        case .Timeout:
            setResultType(.Timeout)
            
        case .Immediate:
            setResultType(.Immediate)
            
        case .Alternating:
            setResultType(.Alternating)
        }
    }
    
    private final func setResultType(resultType: MyIPTestService.ResultType) {
        let myIPTestService = MyIPTestService.sharedService()
        myIPTestService.resultType = resultType
    }
}
