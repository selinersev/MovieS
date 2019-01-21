//
//  HomeViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

final class HomeViewController: UIViewController {

    //MARK: - Properties
    private lazy var viewSource: HomeView = {
        let viewSource = HomeView()
        viewSource.tableView.dataSource = self as! UITableViewDataSource
        viewSource.tableView.delegate = self as! UITableViewDelegate
        return viewSource
    }()
    
    private(set) var viewModel: HomeViewModel
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = viewSource.filterButton
    }
    
    override func loadView() {
        self.view = viewSource
    }
    
    init() {
        viewModel = HomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dummyDatasource()->[Movie] {
        var arr = [Movie]()
        for x in (0...50) {
            let movie = Movie.init(id: x, title: "Name \(x)", overview: "overview \(x)", posterPath: "https://randomuser.me/api/portraits/men/\(x).jpg", releaseDate: Date(), voteAverage: 5, popularity: 4.9)
            arr.append(movie)
        }
        return arr
    }
}
