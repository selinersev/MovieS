//
//  FilterViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 24.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class FilterViewController: UIViewController {

    //MARK: - Properties
    private lazy var viewSource: FilterView = {
        let viewSource = FilterView()
        viewSource.tableView.dataSource = self
        viewSource.tableView.delegate = self
        return viewSource
    }()
    
    private var viewModel: FilterViewModel
    
    weak var delegate: FilterViewControllerDelegate?
    
    // MARK: - Initialization
    init() {
        viewModel = FilterViewModel()
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
        viewModel.fetchGenres()
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
            cell.populate(sortingOption: viewModel.getSelectedSortingType())
            return cell
        case .filterSection:
            let cell: FilterSwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterSwitchCell", for: indexPath) as! FilterSwitchTableViewCell
            guard let genre = viewModel.getGenre(for: indexPath) else {return UITableViewCell()}
            cell.populate(with: genre)
            return cell
        }

    }

}

extension FilterViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sections[section].sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.changeSortingField()
        //delegate?.sendData(soringType: viewModel.getSelectedSortingType())
        tableView.reloadData()
    }
}

protocol FilterViewControllerDelegate: class{
    func sendData(soringType: SortingType)
}
