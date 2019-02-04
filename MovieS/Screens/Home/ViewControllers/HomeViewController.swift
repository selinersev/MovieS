//
//  HomeViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

final class HomeViewController: UIViewController, FilterViewControllerDelegate {

    //MARK: - Properties
    private lazy var viewSource: HomeView = {
        let viewSource = HomeView()
        viewSource.tableView.dataSource = self
        viewSource.tableView.delegate = self
        return viewSource
    }()
    
    private lazy var filterButton: UIBarButtonItem = {
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filterApllied"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(filter))
        return filterButton
    }()
    
    private(set) var viewModel: HomeViewModel
    
    let controller = FilterViewController()
    
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
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.searchController = viewSource.searchController
        self.title = "MovieS"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
        
        viewModel.fetchGenres { [weak self] data in
            guard self == self else {return}
            DispatchQueue.main.async {
                self?.viewSource.tableView.reloadData()
            }
            
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        viewSource.tableView.reloadData()
    }
    
    func sendData(soringType: SortingType) {
        //.............
    }
    

    @objc func filter() {
        let filterViewController = FilterViewController()
        navigationController?.pushViewController(filterViewController, animated: true)
        controller.delegate = self
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
        let controller = DetailViewController()
        navigationController?.pushViewController(controller, animated: true)
        guard let movie = viewModel.getMovie(for: indexPath) else {return}
        controller.movie = movie
    }
}
