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
    
    //MARK: - Properties
    var sections: [SectionType] {
        return [.sortingSection, .filterSection]
    }

    private var sortings:[SortingType] = [.byRate,.byReleaseDate,.byPopularity]
    private let urlString = "https://api.themoviedb.org/3/genre/list?api_key=fc918650eaa758b58bf5cfbfe3178e44"
    private var genreListData: genreList?
    private var selectedIndex = 0
    
    func getSelectedSortingType() -> SortingType{
        return sortings[selectedIndex]
    }
    
    func getSectionType(at section: Int) -> SectionType? {
        guard section < sections.count else {return nil}
        return sections[section]
    }
    
    func getGenre(for indexPath: IndexPath) -> MovieGenre? {
        guard let genresCount = genreListData?.genres.count else {return nil}
        guard genresCount > indexPath.row else {return nil}
        return genreListData?.genres[indexPath.row]
    }
    
    func getRowCount(for section: Int) ->Int{
        guard let genresCount = genreListData?.genres.count else {return 0}
        guard let type = getSectionType(at: section) else {return 0}
        return type == .sortingSection ? 1 : genresCount
    }

    func changeSortingField() {
        if selectedIndex == sortings.count - 1  {
            selectedIndex = 0
        }else{
            selectedIndex += 1
        }
    }
    
    func fetchGenres() {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url){(data,response,err) in
            guard let data = data else { return }
            print(String(data: data, encoding: String.Encoding.utf8))
            do {
                self.genreListData = try JSONDecoder().decode(genreList.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    //tableView.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing json:",jsonErr)
            }
            
            }.resume()
    }
}

// MARK: - Enums
enum SectionType {
    case sortingSection, filterSection
    
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

enum SortingType{
    case byRate,byReleaseDate,byPopularity
    var name:String{
        switch self {
        case .byRate:
            return "By Rate"
        case .byReleaseDate:
            return "By Release Date"
        case .byPopularity:
            return "By Popularity"
        }
    }
    var serviceParam:String{
        switch self {
        case .byPopularity:
            return "popularity.desc"
        default:
            return ""
        }
    }
}
