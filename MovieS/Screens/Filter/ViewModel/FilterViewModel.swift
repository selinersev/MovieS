//
//  FilterViewModel.swift
//  MovieS
//
//  Created by Selin Ersev on 25.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class FilterViewModel {

    // MARK: - Properties
    var selectedGenres = [MovieGenre]()
    var sections: [SectionType] {
        return [.sortingSection, .filterSection]
    }
    
    private let sessionProvider = URLSessionProvider()
    private var sortings: [SortingType] = [.byRate, .byReleaseDate, .byPopularity]
    private var genreListData: GenreList?
    private var selectedIndex = 0

    var selectedSortingType: SortingType {
        return sortings[selectedIndex]
    }

    init(with genres: [MovieGenre], sortingType: SortingType) {
        selectedGenres = genres
        guard let index = sortings.index(of: sortingType) else {return}
        selectedIndex = index
        
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

    func getRowCount(for section: Int) -> Int {
        guard let genresCount = genreListData?.genres.count else {return 0}
        guard let type = getSectionType(at: section) else {return 0}
        return type == .sortingSection ? 1 : genresCount
    }

    func changeSortingField() {
        if selectedIndex == sortings.count - 1 {
            selectedIndex = 0
        } else {
            selectedIndex += 1
        }
    }
    
    func fetchGenres(dataFetched: @escaping ([MovieGenre]?) -> Void ){
        sessionProvider.request(type: GenreList.self, service: MovieService.getGenres) { response in
            switch response {
            case let .success(genres):
                self.genreListData = genres
                dataFetched(genres.genres)
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: - Enums
enum SectionType {
    case sortingSection, filterSection

    var sectionHeaderHeight: CGFloat {
        return 30.0
    }

    var title: String {
        switch self {
        case .sortingSection: return "Sırala"
        case .filterSection: return "Filtrele"
        }
    }
}

enum SortingType {
    case byRate, byReleaseDate, byPopularity
    var name: String {
        switch self {
        case .byRate:
            return "By Rate"
        case .byReleaseDate:
            return "By Release Date"
        case .byPopularity:
            return "By Popularity"
        }
    }
    var serviceParam: String {
        switch self {
        case .byPopularity:
            return "popularity.desc"
        case .byRate:
            return "vote_average.desc"
        case .byReleaseDate:
            return "release_date.desc"
        }
    }
}
