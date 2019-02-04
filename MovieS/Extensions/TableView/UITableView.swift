//
//  UITableView.swift
//  MovieS
//
//  Created by Selin Ersev on 4.02.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

extension UITableView {
    func layoutTableFooterView() {
        guard let footerView = self.tableFooterView else { return }
        footerView.translatesAutoresizingMaskIntoConstraints = false
        let footerWidth = footerView.bounds.size.width
        footerView.widthAnchor.constraint(equalToConstant: footerWidth).isActive = true
        footerView.setNeedsLayout()
        footerView.layoutIfNeeded()
        let footerSize = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = footerSize.height
        var frame = footerView.frame
        frame.size.height = height
        footerView.frame = frame
        self.tableFooterView = footerView
        footerView.widthAnchor.constraint(equalToConstant: footerWidth).isActive = false
        footerView.translatesAutoresizingMaskIntoConstraints = true
    }
}
