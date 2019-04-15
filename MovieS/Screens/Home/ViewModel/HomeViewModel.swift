//
//  HomeViewModel.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    var movieListData: MovieList?
    var filteredMovieListData: MovieList?
    var searchedMovieListData: MovieList?
    var isFiltered = false
    var isSearched = false
    
    var sortingType: SortingType = .byPopularity
    var genres = [MovieGenre]()
    private let sessionProvider = URLSessionProvider()
    
    func getRowCount(for section: Int) ->Int{
        if isSearched == true {
            guard let moviesCount = searchedMovieListData?.movies.count else {return 0}
            return moviesCount
        }
        if isFiltered == true {
            guard let moviesCount = filteredMovieListData?.movies.count else {return 0}
            return moviesCount
        }else {
            guard let moviesCount = movieListData?.movies.count else {return 0}
            return moviesCount
        }
    }
    
    func getMovie(for indexPath: IndexPath) -> Movie? {
        if isSearched == true {
            guard let moviesCount = searchedMovieListData?.movies.count else {return nil}
            guard moviesCount > indexPath.row else {return nil}
            return searchedMovieListData?.movies[indexPath.row]
        }
        if isFiltered == true {
            guard let moviesCount = filteredMovieListData?.movies.count else {return nil}
            guard moviesCount > indexPath.row else {return nil}
            return filteredMovieListData?.movies[indexPath.row]
        }else {
            guard let moviesCount = movieListData?.movies.count else {return nil}
            guard moviesCount > indexPath.row else {return nil}
            return movieListData?.movies[indexPath.row]
        }
    }
    
    func fetchFilteredMovies(dataFetched: @escaping () -> ()) {
        let genresParam = genres.map{String($0.id)}.joined(separator: ",")
        var params = Parameters()
        if genres.count != 0 {
           params["with_genres"] = genresParam
        }
        params ["sort_by"] = sortingType.serviceParam
        sessionProvider.request(type: MovieList.self, service: MovieService.filter(params: params)) { response in
            switch response {
            case let .success(movies):
                self.filteredMovieListData = movies
                dataFetched()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func fetchMovies(dataFetched: @escaping () -> ()){
        sessionProvider.request(type: MovieList.self, service: MovieService.getMovies) { response in
            switch response {
            case let .success(movies):
                self.movieListData = movies
                dataFetched()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func search(searchText: String,dataFetched: @escaping () -> ()) {
        sessionProvider.request(type: MovieList.self, service: MovieService.search(params: ["query": searchText])) { response in
            switch response {
            case let .success(movies):
                self.searchedMovieListData = movies
                dataFetched()
            case let .failure(error):
                print(error)
            }
        }
    }
}
