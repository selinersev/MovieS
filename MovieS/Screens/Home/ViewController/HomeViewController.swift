//
//  HomeViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController{

    //MARK: - Properties
    private lazy var viewSource: HomeView = {
        let viewSource = HomeView()
        viewSource.tableView.dataSource = self
        viewSource.tableView.delegate = self
        viewSource.searchController.searchBar.delegate = self
        return viewSource
    }()
    
    private var viewModel: HomeViewModel
    
    // MARK: - Initialization
    init(tabBarState: TabBarState, genres: [MovieGenre]) {
        viewModel = HomeViewModel()
        viewModel.genres = genres
        viewModel.tabBarState = tabBarState
        super.init(nibName: nil, bundle: nil)
        switch tabBarState {
        case .search:
            navigationItem.leftBarButtonItem = viewSource.trashBarButton
            viewSource.filterButton.isHidden = false
            viewSource.trashButton.isHidden = false
        case .discover:
            viewSource.trashButton.isHidden = true
            viewSource.filterButton.isHidden = true
            navigationItem.leftBarButtonItem = viewSource.backBarButton
        }
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
        switch viewModel.tabBarState {
        case .search:
            viewModel.fetchMovies { [weak self] in
                guard self == self else {return}
                DispatchQueue.main.async {
                    self?.viewSource.tableView.reloadData()
                }
            }
        case .discover:
            viewModel.fetchFilteredMovies { [weak self] in
                guard self == self else {return}
                DispatchQueue.main.async {
                    self?.viewSource.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard !(viewModel.state == .isFiltered) else { return }
        viewSource.tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    func setUpNavBar(){
        navigationItem.rightBarButtonItem = viewSource.filterBarButton
        viewSource.filterButton.addTarget(self, action: #selector(filter), for: .touchUpInside)
        viewSource.trashButton.addTarget(self, action: #selector(clean), for: .touchUpInside)
        viewSource.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        navigationItem.searchController = viewSource.searchController
        self.title = "MovieS"
        self.navigationController?.navigationBar.barTintColor = .blackBackgroundColor
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1),
                                                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
    }

    func refreshUI(){
        viewModel.fetchFilteredMovies { [weak self] in
            guard self == self else {return}
            DispatchQueue.main.async {
                self?.viewSource.tableView.reloadData()
            }
        }
    }
    
    @objc func filter() {
        let controller = FilterViewController(with: viewModel.genres, sortingType: viewModel.sortingType)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func clean() {
        viewModel.state = .normal
        viewModel.fetchMovies { [weak self] in
            guard self == self else {return}
            DispatchQueue.main.async {
                self?.viewSource.tableView.reloadData()
            }
        }
        viewModel.genres = []
        viewModel.sortingType = .byPopularity
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension HomeViewController: FilterViewControllerDelegate{
    func sendFilterOptions(sortingType: SortingType, genres: [MovieGenre]) {
        viewModel.sortingType = sortingType
        viewModel.genres = genres
        viewModel.state = .isFiltered
        refreshUI()
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

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if viewModel.state == .isFiltered{
            guard let movies = viewModel.filteredMovieListData?.movies else {return}
            if !searchText.isEmpty {
                viewModel.filteredMovieListData?.movies = movies.filter { movie in
                    return movie.title.lowercased().contains(searchText.lowercased())
                }
            } else {
                viewModel.searchedMovieListData?.movies = movies
            }
            viewSource.tableView.reloadData()
        }else{
            viewModel.state = .isSearched
            viewModel.search(searchText: searchText) {
                DispatchQueue.main.async {
                    self.viewSource.tableView.reloadData()
                }
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if (viewModel.state == .isFiltered) {
            refreshUI()
            
        }else {
            viewModel.state = .normal
        }
         viewSource.tableView.reloadData()
    }
    

}
