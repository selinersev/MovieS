//
//  FilterApi.swift
//  MovieS
//
//  Created by Selin Ersev on 9.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

struct FilterAPi {
    let baseURL = "https://api.themoviedb.org/3"
    let apiKey = "fc918650eaa758b58bf5cfbfe3178e44"
    let discover = "/discover/movie?"
    
    func filterMovieList(sortingStyle: SortingType, genreID: Int?) -> String{
        guard let genre = genreID else {
            return baseURL + discover + "api_key=\(apiKey)" + "sort_by=\(sortingStyle.serviceParam)"
        }
        return baseURL + discover + "api_key=\(apiKey)" + "sort_by=\(sortingStyle.serviceParam)" + "&with_genres\(genre)"
    }
}
