//
//  UIStackViewExtension.swift
//  MovieS
//
//  Created by Selin Ersev on 28.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

// MARK: - Create UIStackView
extension UIStackView {
    static func create(arrangedSubViews: [UIView] = [],
                       axis: NSLayoutConstraint.Axis = .vertical,
                       alignment: UIStackView.Alignment = .fill,
                       distribution: UIStackView.Distribution = .fill,
                       spacing: CGFloat = .leastNormalMagnitude) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = axis //vertical, horizontal
        stackView.alignment = alignment //arranged subviews perpendicular to the stack view’s axis
        stackView.distribution = distribution //arranged views along the stack view’s axis
        stackView.spacing = spacing
        return stackView
    }
}
