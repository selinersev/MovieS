//
//  SearchTableViewCell.swift
//  MovieS
//
//  Created by Selin Ersev on 5.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

final class SearchTableViewCell: UITableViewCell {

    //MARK: - Properties
    private lazy var movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.layer.masksToBounds = true
        movieImage.layer.cornerRadius = 15
        movieImage.layer.shadowRadius = 10
        movieImage.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        constrain(movieImage){
            $0.height == 30
            $0.width == 30
        }
        return movieImage
    }()
    
    private lazy var movieLabel: UILabel = {
        let movieLabel = UILabel()
        movieLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        movieLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        movieLabel.numberOfLines = 0
        return movieLabel
    }()
    
    private lazy var stackView = UIStackView.create(arrangedSubViews: [movieImage, movieLabel],
                                                    axis: .horizontal,
                                                    spacing: 10.0)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
