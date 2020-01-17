//
//  DetailView.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
import Kingfisher

final class DetailView: UIView {
    
    //MARK: - Properties
    private(set) lazy var poster: UIImageView = {
        let poster = UIImageView()
        poster.sizeAnchor(width: 300, height: 350)
        poster.contentMode = .scaleAspectFit
        return poster
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        let font: UIFont = .boldSystemFont(ofSize: 22.0)
        titleLabel.font = font
        titleLabel.textColor = .lightGrayTextColor
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
        rateLabel.textColor = .lightGrayTextColor
        return rateLabel
    }()
    
    private(set) lazy var overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        overviewLabel.textColor = .lightGrayTextColor
        overviewLabel.numberOfLines = 0
        return overviewLabel
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,rateLabel,overviewLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var baseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [poster,titleStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        backgroundColor = .blackBackgroundColor
        addSubview(scrollView)
        scrollView.addSubview(baseStackView)
        arrangeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Arrange Views
    private func arrangeViews() {
        scrollView.fillSuperview()

        baseStackView.fillSuperview(with: UIEdgeInsets(
            top: 15,
            left: 0,
            bottom: 10.0,
            right: 0
        ))
        baseStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        titleStackView.anchor(leading: baseStackView.leadingAnchor,
                              trailing: baseStackView.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
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
