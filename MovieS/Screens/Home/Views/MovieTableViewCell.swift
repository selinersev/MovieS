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
import FaceAware

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var movieImage: UIImageView = {
        let movieImage = UIImageView()
        return movieImage
    }()
    
    private lazy var movieLabel: UILabel = {
        let movieLabel = UILabel()
        movieLabel.font = UIFont(name: "System", size: 25)
        return movieLabel
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        backgroundColor = .white
        
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
            movieImage.leading == movieImage.superview!.leading + 25
            movieImage.width == 40
            movieImage.height == 50
            movieLabel.leading == movieImage.trailing + 50
            movieLabel.trailing == movieLabel.superview!.trailing - 25
            movieLabel.centerY == movieLabel.superview!.centerY
        }
    }
    
    // MARK: - Populate UI
    func populateUI(movie: Movie){
        movieLabel.text = movie.title
        guard let x = movie.posterPath else {return}
        if let url = URL(string: x){
            movieImage.kf.setImage(with: url, placeholder: UIImage(), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                self.movieImage.clipsToBounds = true
                self.movieImage.focusOnFaces = true
            }
        }
    }
}
