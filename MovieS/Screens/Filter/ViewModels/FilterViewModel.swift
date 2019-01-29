//
//  FilterViewModel.swift
//  MovieS
//
//  Created by Selin Ersev on 25.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation
import UIKit

final class FilterViewModel {
    var sections: [SectionType] {
        return [.sortingSection, .filterSection]
    }
    func getSectionType(at section: Int) -> SectionType? {
        guard section < sections.count else {return nil}
        return sections[section]
    }
    func getRowType(indexPath: IndexPath) -> RowType? {
        guard let sectionType = getSectionType(at: indexPath.section) else {return nil}
        return sectionType.rows[indexPath.row]
        
    }
}
enum RowType {
    case sorting, comedy, war, romance
    var footerButtonTitle: String {
        return "Filtreleri Uygula"
    }
    
    var rowName: String {
        switch self {
        case .sorting: return "Sıralama"
        case .comedy: return "Comedy"
        case .war: return "War"
        case .romance: return "Romance"
        }
    }
}
enum SectionType {
    case sortingSection, filterSection
    
    var rows: [RowType] {
        switch self {
        case .sortingSection:
            return [.sorting]
        case .filterSection:
            return [.comedy, .war, .romance]
        }
    }
    
    var sectionHeaderHeight: CGFloat {
        switch self {
        case .sortingSection:
            return 20.0
        case .filterSection:
            return 20.0
        }
    }
    
    var title: String {
        switch self {
        case .sortingSection: return "Sırala"
        case .filterSection: return "Filtrele"
        }
    }
}
