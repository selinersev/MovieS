//
//  MovieCell.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

final class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.layer.masksToBounds = true
        movieImage.layer.cornerRadius = 5
        movieImage.layer.shadowRadius = 10
        movieImage.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return movieImage
    }()
    
    private lazy var movieLabel: UILabel = {
        let movieLabel = UILabel()
        movieLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        movieLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        return movieLabel
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
        
        addSubview(movieLabel)
        addSubview(movieImage)
        arrangeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK - Arange Views
    private func arrangeViews() {
        constrain(movieImage, movieLabel) { movieImage, movieLabel in
            movieImage.top == movieImage.superview!.top + 15
            movieImage.bottom == movieImage.superview!.bottom - 15
            movieImage.centerY == movieImage.superview!.centerY
            movieImage.leading == movieImage.superview!.leading + 35
            movieImage.width == 80
            movieImage.height == 100
            movieLabel.leading == movieImage.trailing + 50
            movieLabel.trailing == movieLabel.superview!.trailing - 25
            movieLabel.top == movieImage.top + 10
        }
    }
    
    // MARK: - Populate UI
    func populateUI(movie: Movie){
        movieLabel.text = movie.title
        guard let urlString = movie.thumbImageURL, let url = URL(string: urlString) else {return}
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(with: url, placeholder: UIImage(), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            self.movieImage.clipsToBounds = true
        }
    }
}
