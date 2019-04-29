//
//  DiscoverViewModel.swift
//  MovieS
//
//  Created by Selin Ersev on 16.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class DiscoverViewModel {
    
    // MARK: - Properties
    private let sessionProvider = URLSessionProvider()
    private(set) var genreListData: GenreList?

    func getGenre(for indexPath: IndexPath) -> MovieGenre? {
        guard let genresCount = genreListData?.genres.count else {return nil}
        guard genresCount > indexPath.row else {return nil}
        return genreListData?.genres[indexPath.row]
    }
    
    func getRowCount(for section: Int) -> Int {
        guard let genresCount = genreListData?.genres.count else {return 0}
        return genresCount
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
