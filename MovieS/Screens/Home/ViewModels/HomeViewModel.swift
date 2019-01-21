//
//  HomeViewModel.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private(set) var id: Int
    private(set) var overview: String
    private(set) var posterPath: String
    private(set) var releaseDate: Date
    private(set) var voteAverage: Double
    private(set) var popularity: Double
    
    init(id: Int,
         title: String,
         overview: String,
         posterPath: String,
         releaseDate: Date,
         voteAverage: Double,
         popularity: Double ) {
        
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.popularity = popularity
        
    }
}
