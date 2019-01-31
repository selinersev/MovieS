//
//  FilterSwitchTableViewCell.swift
//  MovieS
//
//  Created by Selin Ersev on 25.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

final class FilterSwitchTableViewCell: UITableViewCell {
    
    //MARK - Properties
    private lazy var filterSwitch: UISwitch = {
        let filterSwitch = UISwitch()
        constrain(filterSwitch, block: {
            $0.width == 50
            $0.height == 30
        })
        return filterSwitch
    }()
    
    private lazy var genreLabel = UILabel()
    
    private lazy var stackView = UIStackView.create(arrangedSubViews: [genreLabel, filterSwitch],
                                                    axis: .horizontal,
                                                    spacing: 10.0)
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
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
    func populate(with type: MovieGenre) {
        genreLabel.text = type.name
    }
    
}

