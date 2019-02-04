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
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()

    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1) ]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        searchController.searchBar.setTextColor(color: .white) // ????
        return searchController
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


public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}
