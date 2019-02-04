//
//  DetailViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
import Kingfisher
import FaceAware

final class DetailViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var viewSource: DetailView = {
        let viewSource = DetailView()
        return viewSource
    }()
    
    private(set) var viewModel: DetailViewModel
    
    var movie: Movie?
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
        viewSource.populateUI(movie: movie!)
    }

    // MARK: - Initialization
    init() {
        viewModel = DetailViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


