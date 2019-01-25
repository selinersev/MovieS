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
    
    private lazy var genreLabel: UILabel = {
        let genreLabel = UILabel()
        return genreLabel
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        backgroundColor = .white
        
        addSubview(filterSwitch)
        addSubview(genreLabel)
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
        constrain(filterSwitch, genreLabel) { filterSwitch, genreLabel in
            
        }
    }
    
}
