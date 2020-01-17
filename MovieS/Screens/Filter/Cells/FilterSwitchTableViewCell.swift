//
//  FilterSwitchTableViewCell.swift
//  MovieS
//
//  Created by Selin Ersev on 25.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

protocol FilterSwitchTableViewCellDelegate: class {
    func didSelect(genre:MovieGenre)
}

final class FilterSwitchTableViewCell: UITableViewCell{
    
    //MARK - Properties
    lazy var filterSwitch: UISwitch = {
        let filterSwitch = UISwitch()
        filterSwitch.onTintColor = #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1)
        filterSwitch.sizeAnchor(width: 50, height: 30)
        filterSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return filterSwitch
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrayTextColor
        return label
    }()
    
    private lazy var stackView = UIStackView.create(arrangedSubViews: [genreLabel, filterSwitch],
                                                    axis: .horizontal,
                                                    spacing: 10.0)
    var genre: MovieGenre?

    weak var delegate: FilterSwitchTableViewCellDelegate?
    
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
        stackView.fillSuperview(with: UIEdgeInsets(top: 10, left: 15, bottom: 19, right: 15))
    }
    
    //MARK: - PopulateUI
    func populate(with type: MovieGenre, genreList: [MovieGenre]) {
        genreLabel.text = type.name
        genre = type
        if genreList.contains(type){
            filterSwitch.isOn = true
        } else {
            filterSwitch.isOn = false
        }
    }
    
    @objc func switchValueChanged(){
        guard let selectedGenre = genre else { return }
        delegate?.didSelect(genre: selectedGenre)
    }
}
