//
//  Label.swift
//  MovieS
//
//  Created by Selin Ersev on 28.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

// MARK: Create UILabel
extension UILabel {
    static func create(text: String = "",
                       numberOfLines: Int = 0,
                       font: UIFont = UIFont.systemFont(ofSize: 12.0),
                       textColor: UIColor = .black,
                       textAlignment: NSTextAlignment = .left) -> UILabel {
        
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        return label
    }
}
