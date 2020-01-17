//
//  HomeView.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class HomeView: UIView {
    
    //MARK: - Properties
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .blackBackgroundColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()
    
    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies by Name"
        searchController.searchBar.barTintColor = .blackBackgroundColor
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1) ]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        searchController.searchBar.barStyle = .black
        return searchController
    }()
    
    private(set) lazy var filterButton: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "filterApllied"), for: .normal)
        view.sizeAnchor(width: 27, height: 27)
        return view
    }()
    
    private(set) lazy var trashButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private(set) lazy var backButton: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        view.sizeAnchor(width: 27, height: 27)
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
    
    private(set) lazy var backBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem.init(customView: backButton)
        return barButton
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
        tableView.fillSuperview()
    }
}
