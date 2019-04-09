//
//  HomeViewModel.swift
//  MovieS
//
//  Created by Selin Ersev on 18.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    private let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=fc918650eaa758b58bf5cfbfe3178e44"
    var movieListData: MovieList?
    var filteredMovieListData: MovieList?
    var searchedMovieLisatData: MovieList?
    var isFiltered = false
    
    var sortingType: SortingType = .byPopularity
    var genres = [MovieGenre]()
    var filterApi = FilterAPi()
    
    func getRowCount(for section: Int) ->Int{
        if isFiltered == true {
            guard let moviesCount = filteredMovieListData?.movies.count else {return 0}
            print("******\(moviesCount)")
            return moviesCount
        }else {
            guard let moviesCount = movieListData?.movies.count else {return 0}
            print("-----\(moviesCount)")
            return moviesCount
        }
    }
    
    func getMovie(for indexPath: IndexPath) -> Movie? {
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
    
    func fetchFilteredMovies( dataFetched: @escaping ([Movie]?) -> () ){
        let urlFilterString = filterApi.filterMovieList(sortingStyle: sortingType, genreID: genres[0].id)
        guard let url = URL(string: urlFilterString) else {return}
        URLSession.shared.dataTask(with: url){(data,response,err) in
            guard let data = data else { return }
            print(String(data: data, encoding: String.Encoding.utf8))
            do {
                self.filteredMovieListData = try JSONDecoder().decode(MovieList.self, from: data)
                dataFetched(self.filteredMovieListData?.movies)
                
            }catch let jsonErr {
                print("Error serializing json:",jsonErr)
            }
            
            }.resume()
    }
    
    func fetchMovies( dataFetched: @escaping ([Movie]?) -> () ) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url){(data,response,err) in
            guard let data = data else { return }
//            print(String(data: data, encoding: String.Encoding.utf8))
            do {
                self.movieListData = try JSONDecoder().decode(MovieList.self, from: data)
                dataFetched(self.movieListData?.movies)

            }catch let jsonErr {
                print("Error serializing json:",jsonErr)
            }

            }.resume()
//        let request = APIRequest(method: .get, path: "discover/movie")
//        APIClient().perform(request) { (result) in
//            print(request)
//            switch result {
//            case .success(let response):
//                if let response = try? response.decode(to: MovieList.self) {
//                    let movieList = response.body
//                    print("Received posts: \(movieList.movies)")
//                    self.movieListData = movieList
//                    dataFetched(self.movieListData?.movies)
//                } else {
//                    print("Failed to decode response")
//                    print(String.init(data: response.body!, encoding: String.Encoding.utf8))
//                }
//            case .failure:
//                print("Error perform network request")
//            }
//        }
    }
}
