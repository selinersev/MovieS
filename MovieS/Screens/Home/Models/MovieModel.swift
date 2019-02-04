//
//  Movie.swift
//  MovieS
//
//  Created by Selin Ersev on 15.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

struct MovieList: Codable {
    let movies: [Movie]
}

struct Movie: Codable {
    
    var id: Int
    var title: String
    var posterPath: String?
    var overview: String?
    var releaseDate: Date?
    //var genreIDs: [Int]?
    var voteAverage: Double?
    var popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        //case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
    }
}

