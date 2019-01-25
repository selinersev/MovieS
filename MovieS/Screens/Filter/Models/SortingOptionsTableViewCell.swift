//
//  SortingOptionsTableViewCell.swift
//  MovieS
//
//  Created by Selin Ersev on 25.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

final class SortingOptionsTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var sortingIcon: UIImageView = {
        let sortingIcon = UIImageView()
        sortingIcon.image = #imageLiteral(resourceName: "sort")
        sortingIcon.contentMode = .left
        constrain(sortingIcon, block: {
            $0.height == 16
            $0.width == 14
        })
        return sortingIcon
    }()
    
    private lazy var sortingNameLabel: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.font = font
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [sortingIcon,sortingNameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        backgroundColor = .white
        
        addSubview(stackView)
        constrain(stackView, block: { $0.edges == $0.superview!.edges.inseted(by: 15.0) })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - PopulateUI
    func populate(with sortingOption: String) {
        sortingNameLabel.text = sortingOption
    }
    
}
