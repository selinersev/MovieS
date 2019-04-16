//
//  Discover.swift
//  MovieS
//
//  Created by Selin Ersev on 16.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit
import Cartography

final class DiscoverView: UIView {
    
    // MARK: - Properties
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let cellSize = CGSize(width:105 , height:130)
        layout.itemSize = cellSize
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        layout.invalidateLayout()
        return layout
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        collectionView.register(DiscoverCollectionViewCell.self,forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
        return collectionView
    }()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        addSubview(collectionView)
        
        constrain(collectionView){ collectionView in
            collectionView.leading == collectionView.superview!.leading
            collectionView.trailing == collectionView.superview!.trailing
            collectionView.top == collectionView.superview!.top
            collectionView.bottom == collectionView.superview!.bottom
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
