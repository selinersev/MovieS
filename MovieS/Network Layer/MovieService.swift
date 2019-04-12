//
//  MovieService.swift
//  MovieS
//
//  Created by Selin Ersev on 11.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

enum MovieService: ServiceProtocol {
    case filter(params: Parameters)
    case getGenres
    case getMovies
    case search(params: Parameters)
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .filter:
            return "/discover/movie"
        case .getGenres:
            return "/genre/list"
        case .getMovies:
            return "/movie/top_rated"
        case .search:
            return "/search/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            default:
            return .get
        }
        
    }
    
    var queryItem: QueryItem {
        switch self {
        case .filter(let params):
            return .requestParameters(params)
        case .search(let params):
            return .requestParameters(params)
        default:
            return .requestPlain
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
    var apikey: String{
        return "fc918650eaa758b58bf5cfbfe3178e44"
    }
}
