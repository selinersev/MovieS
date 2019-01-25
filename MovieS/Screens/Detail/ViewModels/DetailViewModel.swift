//
//  DetailViewModel.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    var movie: Movie
    private var id: Int {
        return movie.id
    }
    var overview: String? {
        return movie.overview
    }
    var posterPath: String? {
        return movie.posterPath
    }
    var releaseDate: Date? {
        return movie.releaseDate
    }
    var voteAverage: Double? {
        return movie.voteAverage
    }
    var popularity: Double? {
        return movie.popularity
    }
    var title: String {
        return movie.title
    }
//    var genreIDs : [Int]? {
//        return movie.genreIDs
//    }
    
    
    init(movie: Movie) {
        self.movie = movie
    }
}
