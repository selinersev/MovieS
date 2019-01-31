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
    
    private lazy var stackView = UIStackView.create(arrangedSubViews: [sortingIcon, sortingNameLabel],
                                                    axis: .horizontal,
                                                    spacing: 10.0)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
        
        addSubview(stackView)
        arrangeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Arange Views
    private func arrangeViews() {
        constrain(stackView) { stackView in
            stackView.left == stackView.superview!.left + 15.0
            stackView.right == stackView.superview!.right - 15.0
            stackView.top == stackView.superview!.top + 10.0
            stackView.bottom == stackView.superview!.bottom - 10.0
        }
    }
    //MARK: - PopulateUI
    func populate(sortingOption: SortingType){
        sortingNameLabel.text = sortingOption.name
    }
    
}
