//
//  FilterSwitchTableViewCell.swift
//  MovieS
//
//  Created by Selin Ersev on 25.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Cartography

final class FilterSwitchTableViewCell: UITableViewCell{
    
    //MARK - Properties
    lazy var filterSwitch: UISwitch = {
        let filterSwitch = UISwitch()
        filterSwitch.onTintColor = #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1)
        constrain(filterSwitch, block: {
            $0.width == 50
            $0.height == 30
        })
        return filterSwitch
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
    
    private lazy var stackView = UIStackView.create(arrangedSubViews: [genreLabel, filterSwitch],
                                                    axis: .horizontal,
                                                    spacing: 10.0)
    var selectedGenres = [MovieGenre]()
    let controller = FilterViewController()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        controller.delegate = self
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
    func populate(with type: MovieGenre, isSelected: Bool) {
        genreLabel.text = type.name
    }
    
}

extension FilterSwitchTableViewCell: FilterViewControllerDelegate{
    func sendData(soringType: SortingType) {
        
    }
    
    func sendSelectedGenre(genre: MovieGenre) {
        selectedGenres.append(genre)
    }
    
    
}
