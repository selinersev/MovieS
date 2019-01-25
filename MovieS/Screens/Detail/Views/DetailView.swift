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

//protocol MovieDetailDelegate: class {
//    func sendData(movie: Movie)
//}

final class DetailView: UIView {
    
    //MARK: - Properties
    private(set) lazy var poster: UIImageView = {
        let poster = UIImageView()
        return poster
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        let font: UIFont = .boldSystemFont(ofSize: 22.0)
        titleLabel.font = font
        return titleLabel
    }()
    
//    private(set) lazy var genreLabel: UILabel = {
//        let genreLabel = UILabel()
//        let font: UIFont = .boldSystemFont(ofSize: 17.0)
//        genreLabel.font = font
//        return genreLabel
//    }()
    
    private(set) lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        let font: UIFont = .boldSystemFont(ofSize: 20.0)
        rateLabel.font = font
        return rateLabel
    }()
    
    private(set) lazy var overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        return overviewLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [titleLabel,rateLabel,overviewLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 25
        return stackView
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        [poster,stackView].forEach(addSubview(_:))
        arrangeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Arrange Views
    private func arrangeViews() {
        constrain(stackView, poster) { stackView, poster in
       
            stackView.leading == stackView.superview!.leading + 25
            stackView.top == poster.bottom - 25
            stackView.trailing == stackView.superview!.trailing - 25
            stackView.bottom == stackView.superview!.bottom + 50
            poster.leading == poster.superview!.leading + 25
            poster.trailing == poster.superview!.trailing - 25
            poster.top == poster.superview!.top + 100
            poster.height == 300
        }
    }

    func populateUI(movie: Movie){
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        //genreLabel.text = movie.genreIDs as? String
        guard let rate = movie.voteAverage else {return}
        rateLabel.text = String(rate)
        guard let x = movie.posterPath else {return}
        if let url = URL(string: x){
            poster.kf.setImage(with: url, placeholder: UIImage(), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                self.poster.clipsToBounds = true
                //self.poster.focusOnFaces = true
            }
        }
    }
}
