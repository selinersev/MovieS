//
//  SortingOptionsTableViewCell.swift
//  MovieS
//
//  Created by Selin Ersev on 25.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class SortingOptionsTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var sortingIcon: UIImageView = {
        let sortingIcon = UIImageView()
        sortingIcon.image = #imageLiteral(resourceName: "sort")
        sortingIcon.contentMode = .left
        sortingIcon.sizeAnchor(width: 14, height: 18)
        return sortingIcon
    }()
    
    private lazy var sortingNameLabel: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        label.font = font
        label.textAlignment = .left
        label.textColor = .lightGrayTextColor
        return label
    }()
    
    private lazy var stackView = UIStackView.create(arrangedSubViews: [sortingIcon, sortingNameLabel],
                                                    axis: .horizontal,
                                                    spacing: 10.0)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .blackBackgroundColor
        
        addSubview(stackView)
        arrangeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Arange Views
    private func arrangeViews() {
        stackView.fillSuperview(with: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }
    //MARK: - PopulateUI
    func populate(sortingOption: SortingType){
        sortingNameLabel.text = sortingOption.name
    }
    
}
