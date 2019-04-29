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

final class DetailView: UIView {
    
    //MARK: - Properties
    private(set) lazy var poster: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleAspectFit
        return poster
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        let font: UIFont = .boldSystemFont(ofSize: 22.0)
        titleLabel.font = font
        titleLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return titleLabel
    }()
    
    private(set) lazy var genreLabel: UILabel = {
        let genreLabel = UILabel()
        let font: UIFont = .boldSystemFont(ofSize: 17.0)
        genreLabel.font = font
        return genreLabel
    }()
    
    private(set) lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        let font: UIFont = .boldSystemFont(ofSize: 20.0)
        rateLabel.font = font
        rateLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return rateLabel
    }()
    
    private(set) lazy var overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        overviewLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        overviewLabel.numberOfLines = 0
        return overviewLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [titleLabel,rateLabel,overviewLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
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
            stackView.top == poster.bottom + 40
            stackView.trailing == stackView.superview!.trailing - 25
            poster.leading == poster.superview!.leading + 25
            poster.trailing == poster.superview!.trailing - 25
            poster.top == poster.superview!.top + 150
            poster.height == 300
        }
    }

    func populateUI(movie: Movie){
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        guard let rate = movie.voteAverage else {return}
        rateLabel.text = String(rate)
        guard let urlString = movie.fullImageURL, let url = URL(string: urlString) else {return}
        poster.kf.setImage(with: url, placeholder: UIImage(), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            self.poster.clipsToBounds = true
        }
    }
}
