//
//  UIColor.swift
//  MovieS
//
//  Created by Selin Ersev on 16.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
