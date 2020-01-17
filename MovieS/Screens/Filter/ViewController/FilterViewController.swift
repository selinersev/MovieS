//
//  FilterViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 24.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
    func sendFilterOptions(sortingType: SortingType, genres: [MovieGenre])
}

final class FilterViewController: UIViewController {

    //MARK: - Properties
    private lazy var viewSource: FilterView = {
        let viewSource = FilterView()
        viewSource.tableView.dataSource = self
        viewSource.tableView.delegate = self
        viewSource.filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        return viewSource
    }()
    
    private var viewModel: FilterViewModel
    
    weak var delegate: FilterViewControllerDelegate?
    
    // MARK: - Initialization
    init(with genres: [MovieGenre], sortingType: SortingType) {
        viewModel = FilterViewModel(with: genres, sortingType: sortingType)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchGenres { [weak self] data in
            guard self == self else {return}
            DispatchQueue.main.async {
                self?.viewSource.tableView.reloadData()
            }
        }
    }
    
    @objc func filterButtonAction(){
        delegate?.sendFilterOptions(sortingType: viewModel.selectedSortingType , genres: viewModel.selectedGenres)
        print(viewModel.selectedSortingType.serviceParam)
        print(viewModel.selectedGenres)
        navigationController?.popViewController(animated: true)
    }
    
}

extension FilterViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = viewModel.getSectionType(at: indexPath.section) else {return UITableViewCell()}
        switch sectionType {
        case .sortingSection:
            let cell: SortingOptionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SortingCell", for: indexPath) as! SortingOptionsTableViewCell
            cell.populate(sortingOption: viewModel.selectedSortingType)
            return cell
        case .filterSection:
            let cell: FilterSwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterSwitchCell", for: indexPath) as! FilterSwitchTableViewCell
            guard let genre = viewModel.getGenre(for: indexPath) else {return UITableViewCell()}
            cell.delegate = self
            cell.populate(with: genre, genreList: viewModel.selectedGenres)
            return cell
        }

    }

}

extension FilterViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sections[section].sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
        headerView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = viewModel.getSectionType(at: indexPath.section) else {return}
        switch sectionType {
        case .sortingSection:
            viewModel.changeSortingField()
        case .filterSection:
            return
        }
        tableView.reloadData()
    }
}

extension FilterViewController: FilterSwitchTableViewCellDelegate {
    func didSelect(genre: MovieGenre) {
        if viewModel.selectedGenres.contains(genre) {
            guard let index = viewModel.selectedGenres.index(of: genre) else {return}
            viewModel.selectedGenres.remove(at: index)
        }else {
            viewModel.selectedGenres.append(genre)
        }
    }
}

