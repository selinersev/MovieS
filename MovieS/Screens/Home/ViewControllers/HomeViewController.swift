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
        viewSource.tableView.dataSource = self
        viewSource.tableView.delegate = self
        return viewSource
    }()
    
    private(set) var viewModel: HomeViewModel
    
    var movies = [Movie]()
    //weak var delegate: MovieDetailDelegate?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = viewSource.filterButton
        navigationItem.searchController = viewSource.searchController
        self.title = "MovieS"
        movies = dummyDatasource()
    }
    
    override func loadView() {
        self.view = viewSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewSource.tableView.reloadData()
    }
    
    // MARK: - Initialization
    init() {
        viewModel = HomeViewModel(id: 0, title: "", overview: "", posterPath: "", releaseDate: Date(), voteAverage: 0.0, popularity: 0.0)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dummyDatasource()->[Movie] {
        var arr = [Movie]()
        for x in (0...10) {
            let movie = Movie.init(id: x, title: "Name \(x)", overview: "overview \(x)", posterPath: "https://randomuser.me/api/portraits/men/\(x).jpg", releaseDate: Date(), voteAverage: 5, popularity: 4.9)
            arr.append(movie)
        }
        return arr
    }
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.populateUI(movie: movies[indexPath.row])
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailViewController()
        navigationController?.pushViewController(controller, animated: true)
        //delegate?.sendData(movie: movies[indexPath.row])
        controller.movie = movies[indexPath.row]
    }
}
