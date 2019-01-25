//
//  FilterViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 24.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    //MARK: - Properties
    private lazy var viewSource: FilterView = {
        let viewSource = FilterView()
        viewSource.tableView.dataSource = self
        viewSource.tableView.delegate = self
        return viewSource
    }()
    
    private(set) var viewModel: FilterViewModel
    // MARK: - Initialization
    init() {
        viewModel = FilterViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
}

extension FilterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSwitchCell", for: indexPath) as! FilterSwitchTableViewCell
        return cell
    }
}

extension FilterViewController: UITableViewDelegate{
    
}
