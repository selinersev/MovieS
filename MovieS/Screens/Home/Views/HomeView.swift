//
//  HomeView.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

final class HomeView: UIView {
    
    //MARK: - Properties
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
        tableView.separatorInset = UIEdgeInsets.init(top: tableView.rowHeight, left: 10.0, bottom: 0, right: 10.0)
        tableView.showsVerticalScrollIndicator = false
        //tableView.separatorStyle = .none
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()

    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return searchController
    }()
    
    private(set) lazy var filterButton: UIBarButtonItem = {
        let filterButton = UIBarButtonItem()
        filterButton.image = #imageLiteral(resourceName: "filterApllied")
        return filterButton
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        addSubview(tableView)
        arrangeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Arrange Views
    private func arrangeViews() {
        constrain(tableView) { tableView in
            tableView.edges == inset(tableView.superview!.edges, 0, 0, 0, 0)
        }
    }
}


