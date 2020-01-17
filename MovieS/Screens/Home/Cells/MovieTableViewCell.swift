//
//  MovieCell.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
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
        movieLabel.textColor = .lightGrayTextColor
        movieLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        movieLabel.numberOfLines = 0
        return movieLabel
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .blackBackgroundColor
        
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
        movieImage.anchor(top: self.topAnchor,
                          leading: self.leadingAnchor,
                          bottom: self.bottomAnchor,
                          padding: UIEdgeInsets(top: 15, left: 35, bottom: 15, right: 0),
                          size: CGSize(width: 80, height: 100))

        movieLabel.anchor(top: movieImage.topAnchor,
                          leading: movieImage.trailingAnchor,
                          trailing: self.trailingAnchor,
                          padding: UIEdgeInsets(top: 10, left: 50, bottom: 0, right: 25))
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
