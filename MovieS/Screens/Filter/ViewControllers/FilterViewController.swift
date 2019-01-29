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
    
    private var genres = [String]()
    
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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        genres = dummyDatasource()
    }
    
    func dummyDatasource()->[String] {
        var arr = [String]()
        arr = ["Action","Advanture", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "History", "Horror", "Music", "Mystery", "Romance", "Science Fiction", "TV Movie", "Thriller", "War", "Western"]
        return arr
    }
}

extension FilterViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = viewModel.getRowType(indexPath: indexPath) else  {
            return UITableViewCell()
        }
        
        switch rowType {
        case .comedy, .romance, .war:
            let cell: FilterSwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterSwitchCell", for: indexPath) as! FilterSwitchTableViewCell
            cell.populate(with: rowType)
            return cell
        case .sorting:
            let cell: SortingOptionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SortingCell", for: indexPath) as! SortingOptionsTableViewCell
            cell.populate(with: rowType)
            return cell
        }
    }
}

extension FilterViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sections[section].sectionHeaderHeight
    }
}
