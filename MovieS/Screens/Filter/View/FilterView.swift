//
//  FilterView.swift
//  MovieS
//
//  Created by Selin Ersev on 24.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class FilterView: UIView {
    
    //MARK: - Properties
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 130.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 40.0
        tableView.backgroundColor = .blackBackgroundColor
        tableView.register(FilterSwitchTableViewCell.self, forCellReuseIdentifier: "FilterSwitchCell")
        tableView.register(SortingOptionsTableViewCell.self, forCellReuseIdentifier: "SortingCell")
        tableView.tableFooterView = footerView
        tableView.layoutTableFooterView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var footerTopSpaceView: UIView = {
        let view = UIView()
        view.sizeAnchor(height: 35)
        return view
    }()
    
    private(set) lazy var filterButton: UIButton = {
        let font: UIFont = .boldSystemFont(ofSize: 17.0)
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1)
        button.setTitle("Filter", for: .normal)
        button.setTitleColor( .lightGrayTextColor, for: .normal)
        button.titleLabel?.font = font
        button.layer.borderWidth = 3.0
        button.layer.cornerRadius = 25.0
        button.layer.borderColor = UIColor.lightGrayTextColor.cgColor
        button.sizeAnchor(width: 60, height: 60)
        return button
    }()
    
    private lazy var footerView: UIStackView = .create(arrangedSubViews: [footerTopSpaceView, filterButton])
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)

        addSubview(tableView)
        tableView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
