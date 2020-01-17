//
//  DetailViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var viewSource: DetailView = {
        let viewSource = DetailView()
        return viewSource
    }()
    
    private(set) var viewModel: DetailViewModel
    
    private var movie: Movie?
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSource.populateUI(movie: movie!)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    // MARK: - Initialization
    init(with movie: Movie) {
        self.movie = movie
        viewModel = DetailViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


