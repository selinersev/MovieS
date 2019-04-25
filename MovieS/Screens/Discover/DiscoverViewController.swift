//
//  DiscoverViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 16.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class DiscoverViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewSource: DiscoverView = {
        let viewSource = DiscoverView()
        viewSource.collectionView.dataSource = self
        viewSource.collectionView.delegate = self
        return viewSource
        
    }()
    
    private var viewModel: DiscoverViewModel
    
    // MARK: - Initialization
    init() {
        viewModel = DiscoverViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
        setUpNavBar()
        viewModel.fetchGenres { [weak self] data in
            guard self == self else {return}
            DispatchQueue.main.async {
                self?.viewSource.collectionView.reloadData()
            }
        }
    }
    
    func setUpNavBar(){
        self.title = "Discover"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1),
                                                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
    }
}

// MARK: - CollectionView Delegate
extension DiscoverViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let genre = viewModel.getGenre(for: indexPath) else {return}
        let controller = HomeViewController(tabBarState: .discover, genres: [genre])
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - CollectionView Datasource
extension DiscoverViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRowCount(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DiscoverCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! DiscoverCollectionViewCell
        guard let genre = viewModel.getGenre(for: indexPath) else {return UICollectionViewCell()}
        cell.populate(genre: genre.name)
        return cell
    }
    
}
