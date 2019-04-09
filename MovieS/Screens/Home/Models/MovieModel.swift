//
//  Movie.swift
//  MovieS
//
//  Created by Selin Ersev on 15.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

struct MovieList: Decodable {
    var movies: [Movie]
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)
        
    }
}

struct Movie: Decodable {
    
    var id: Int
    var title: String
    private var posterPath: String?
    var overview: String?
    var releaseDate: String?
    var genreIDs: [Int]?
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
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        posterPath = try values.decode(String.self, forKey: .posterPath)
        overview = try values.decode(String.self, forKey: .overview)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        voteAverage = try values.decode(Double.self, forKey: .voteAverage)
        popularity = try values.decode(Double.self, forKey: .popularity)
        genreIDs = try values.decode([Int].self, forKey: .genreIDs)
    }
}

