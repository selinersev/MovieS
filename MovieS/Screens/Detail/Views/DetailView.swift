//
//  DetailView.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher
import FaceAware

protocol MovieDetailViewDatasource {
    var movie: Movie { get }
}

final class DetailView: UIView {
    
    //MARK: - Properties
    private(set) lazy var poster: UIImageView = {
        let poster = UIImageView()
        return poster
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    private(set) lazy var genreLabel: UILabel = {
        let genreLabel = UILabel()
        return genreLabel
    }()
    
    private(set) lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        return rateLabel
    }()
    
    private(set) lazy var overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        return overviewLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [titleLabel,rateLabel,genreLabel,overviewLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 25
        return stackView
    }()
    
    private func arrangeViews() {
        constrain(stackView, poster) { stackView, poster in
            stackView.leading == stackView.superview!.leading + 25
            stackView.top == poster.bottom - 25
            stackView.trailing == stackView.superview!.trailing - 25
            stackView.bottom == stackView.superview!.bottom + 50
            poster.leading == poster.superview!.leading + 25
            poster.trailing == poster.superview!.trailing - 25
            poster.top == poster.superview!.top - 50
        }
    }

    func populateUI(dataSource: MovieDetailViewDatasource){
        titleLabel.text = dataSource.movie.title
        overviewLabel.text = dataSource.movie.overview
        genreLabel.text = dataSource.movie.genreIDs as? String
        rateLabel.text = dataSource.movie.voteAverage as? String
        guard let x = dataSource.movie.posterPath else {return}
        if let url = URL(string: x){
            poster.kf.setImage(with: url, placeholder: UIImage(), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                self.poster.clipsToBounds = true
                self.poster.focusOnFaces = true
            }
        }
    }
}
