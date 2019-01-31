//
//  Movie.swift
//  MovieS
//
//  Created by Selin Ersev on 15.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    var id: Int
    var title: String
    var posterPath: String?
    var overview: String?
    var releaseDate: Date?
//    var genreIDs: [Int]?
    var voteAverage: Double?
    var popularity: Double?
    
//    init(id: Int, title: String, overview: String? = nil, posterPath: String? = nil, releaseDate: Date? = nil, voteAverage: Double, popularity: Double?) {
//        self.id = id
//        self.title = title
//        self.overview = overview
//        self.posterPath = posterPath
//        self.releaseDate = releaseDate
//        self.voteAverage = voteAverage
//        self.popularity = popularity
//    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
//        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
    }
}

