//
//  DiscoverCollectionViewCell.swift
//  MovieS
//
//  Created by Selin Ersev on 16.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
import Cartography

final class DiscoverCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private lazy var baseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 45
        view.backgroundColor = .random
        constrain(view){view in
            view.height == 90
            view.width == 90
        }
        view.addSubview(genreLabel)
        return view
    }()
    
    private(set) lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(baseView)
        constrain(genreLabel){genreLabel in
            genreLabel.centerX == genreLabel.superview!.centerX
            genreLabel.centerY == genreLabel.superview!.centerY
            genreLabel.width == 90
        }
        constrain(baseView){baseView in
            baseView.centerX == baseView.superview!.centerX
            baseView.centerY == baseView.superview!.centerY
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PopulateUI
    func populate(genre: String) {
        genreLabel.text = genre
    }
}
