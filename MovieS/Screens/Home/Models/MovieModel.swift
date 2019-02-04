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
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable {
    
    var id: Int
    var title: String
    private var posterPath: String?
    var overview: String?
    var releaseDate: String?
    //var genreIDs: [Int]?
    var voteAverage: Double?
    var popularity: Double?
    
    var thumbImageURL: String? {
        guard let path = posterPath else {return nil}
        return "https://image.tmdb.org/t/p/w185/" + path
    }
    
    var fullImageURL: String? {
        guard let path = posterPath else {return nil}
        return "https://image.tmdb.org/t/p/w500/" + path
    }
    
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

