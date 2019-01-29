//
//  TableSectionHeaderView.swift
//  MovieS
//
//  Created by Selin Ersev on 28.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

protocol TableSectionHeaderViewDatasource {
    var _title: String { get }
    var _titleColor: UIColor { get }
    var _titleFont: UIFont { get }
    var _viewBgColor: UIColor { get }
}

extension TableSectionHeaderViewDatasource {
    var _titleColor: UIColor {
        return .gray
    }
    
    var _titleFont: UIFont {
        return .systemFont(ofSize: 15.0, weight: .heavy)
    }
    
    var _viewBgColor: UIColor {
        return .white
    }
}  


final class TableSectionHeaderView: UIView {

    // MARK: - Properties
    private(set) lazy var titleLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 15.0, weight: .heavy)
        let label: UILabel = .create(font: font, textColor: .gray, textAlignment: .left)
        label.accessibilityTraits = UIAccessibilityTraits.header
        return label
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        constrain(titleLabel, block: {
            $0.leading == $0.superview!.leading + 15.0
            $0.trailing == $0.superview!.trailing - 15.0
            $0.top == $0.superview!.top + 8.0
            $0.bottom == $0.superview!.bottom - 8.0
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Populate UI
extension TableSectionHeaderView {
    func populate(with datasource: TableSectionHeaderViewDatasource) {
        titleLabel.text = datasource._title
        titleLabel.textColor = datasource._titleColor
        titleLabel.font = datasource._titleFont
        
        backgroundColor = datasource._viewBgColor
        
        layoutIfNeeded()
    }
}
