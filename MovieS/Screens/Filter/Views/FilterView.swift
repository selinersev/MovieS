//
//  FilterView.swift
//  MovieS
//
//  Created by Selin Ersev on 24.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
import Cartography

final class FilterView: UIView {
    
    //MARK: - Properties
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 130.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 40.0
        tableView.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
        tableView.separatorInset = UIEdgeInsets.init(top: tableView.rowHeight, left: 0.0, bottom: 0, right: 0.0)
        tableView.register(FilterSwitchTableViewCell.self, forCellReuseIdentifier: "FilterSwitchCell")
        tableView.register(SortingOptionsTableViewCell.self, forCellReuseIdentifier: "SortingCell")
        return tableView
    }()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        addSubview(tableView)
        constrain(tableView, block: { $0.edges == $0.superview!.edges })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
