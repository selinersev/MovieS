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
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()
    
    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies by Name"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1) ]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        searchController.searchBar.barStyle = .black
        return searchController
    }()
    
    private(set) lazy var filterButton: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "filterApllied"), for: .normal)
        view.frame = CGRect(x: 0, y: 0, width: 27, height: 27)
        constrain(view) { x in
            x.height == 27.0
            x.width == 27.0
        }
        return view
    }()
    
    private(set) lazy var trashButton: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "trash"), for: .normal)
        view.frame = CGRect(x: 0, y: 0, width: 27, height: 27)
        constrain(view) { x in
            x.height == 27.0
            x.width == 27.0
        }
        return view
    }()
    
    
    private(set) lazy var filterBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem.init(customView: filterButton)
        return barButton
    }()
    
    private(set) lazy var trashBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem.init(customView: trashButton)
        return barButton
    }()
    
    // MARK: - Initialization
    init(isFilterButtonHide: Bool, isTrashButtonHide: Bool) {
        super.init(frame: .zero)
        filterButton.isHidden = isFilterButtonHide
        trashButton.isHidden = isTrashButtonHide
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
