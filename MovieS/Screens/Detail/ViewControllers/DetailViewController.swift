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

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var viewSource: DetailView = {
        let viewSource = DetailView()
        return viewSource
    }()
    
    private(set) var viewModel: DetailViewModel
    
    var movie = Movie(id: 0, title: "", overview: "", posterPath: "", releaseDate: Date(), voteAverage: 0.0, popularity: 0.0)
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = viewSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
        viewSource.overviewLabel.text = viewModel.overview
        viewSource.populateUI(movie: movie)
    }

    // MARK: - Initialization
    init() {
        viewModel = DetailViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension DetailViewController: MovieDetailDelegate{
//    func sendData(movie: Movie) {
//        self.movie.id = movie.id
//        self.movie.genreIDs = movie.genreIDs
//        self.movie.overview = movie.overview
//        self.movie.popularity = movie.popularity
//        self.movie.posterPath = movie.posterPath
//    }
//
//
//}
