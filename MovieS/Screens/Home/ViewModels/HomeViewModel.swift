//
//  HomeViewModel.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    private var id: Int
    private var overview: String
    private var posterPath: String
    private var releaseDate: Date
    private var voteAverage: Double
    private var popularity: Double
    
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
