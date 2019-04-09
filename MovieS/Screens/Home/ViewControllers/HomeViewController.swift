//
//  HomeViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

final class HomeViewController: UIViewController{

    //MARK: - Properties
    var networkManager: NetworkManager = NetworkManager()
    
    private lazy var viewSource: HomeView = {
        let viewSource = HomeView()
        viewSource.tableView.dataSource = self
        viewSource.tableView.delegate = self
//        viewSource.searchController.searchResultsUpdater = self
//        viewSource.searchController.searchBar.delegate = self
        return viewSource
    }()
    
    private lazy var filterButton: UIBarButtonItem = {
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filterApllied"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(filter))
        return filterButton
    }()
    
    private(set) var viewModel: HomeViewModel
    
    // MARK: - Initialization
    init() {
        viewModel = HomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSource.searchController.hidesNavigationBarDuringPresentation = true
        self.definesPresentationContext = true
        setUpNavBar()
//        networkManager.getNewMovies(page: 1) { movies, error in
//            if let movies = movies {
//                self.viewModel.movieListData?.movies = movies
//                DispatchQueue.main.async {
//                    self.viewSource.tableView.reloadData()
//                }
//            }
//        }
        viewModel.fetchMovies { [weak self] data in
            guard self == self else {return}
            DispatchQueue.main.async {
                self?.viewSource.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(viewModel.isFiltered)
        if viewModel.isFiltered == true {
            viewModel.fetchFilteredMovies { [weak self] data in
                guard self == self else {return}
                DispatchQueue.main.async {
                    self?.viewSource.tableView.reloadData()
                }
            }
        }else {
            viewSource.tableView.reloadData()
        }
    }

    func setUpNavBar(){
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.searchController = viewSource.searchController
        self.title = "MovieS"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
    }

    @objc func filter() {
        let controller = FilterViewController(with: viewModel.genres, sortingType: viewModel.sortingType)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        guard let movie = viewModel.getMovie(for: indexPath) else {return UITableViewCell()}
        cell.populateUI(movie: movie)
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        guard let movie = viewModel.getMovie(for: indexPath) else {return}
         let controller = DetailViewController(with: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController: FilterViewControllerDelegate{
    func sendFilterOptions(sortingType: SortingType, genres: [MovieGenre], filtered: Bool) {
        viewModel.sortingType = sortingType
        viewModel.genres = genres
        viewModel.isFiltered = filtered
    }
}

//extension HomeViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let movies = viewModel.movieListData?.movies else {return}
//        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//            viewModel.isSearching = true
//            viewModel.filteredMovieListData?.movies = movies.filter { movie in
//                return movie.title.lowercased().contains(searchText.lowercased())
//            }
//        } else {
//            viewModel.filteredMovieListData?.movies = movies
//        }
//        viewSource.tableView.reloadData()
//    }
//}
//
//extension HomeViewController: UISearchBarDelegate {
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        viewModel.isSearching = false
//    }
//}
