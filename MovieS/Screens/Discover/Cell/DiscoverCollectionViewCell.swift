//
//  DiscoverCollectionViewCell.swift
//  MovieS
//
//  Created by Selin Ersev on 16.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class DiscoverCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private lazy var baseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 45
        view.backgroundColor = .random
        view.sizeAnchor(width: 90, height: 90)
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
        baseView.centerAnchor(centerY: self.centerYAnchor,
                              centerX: self.centerXAnchor)
        
        genreLabel.sizeAnchor(width: 90)
        genreLabel.centerAnchor(centerY: baseView.centerYAnchor,
                                centerX: baseView.centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PopulateUI
    func populate(genre: String) {
        genreLabel.text = genre
    }
}
