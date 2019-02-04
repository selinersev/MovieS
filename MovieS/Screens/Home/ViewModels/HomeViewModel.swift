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
    private var movieListData: MovieList?
    
    func getRowCount(for section: Int) ->Int{
        guard let moviesCount = movieListData?.movies.count else {return 0}
        return moviesCount
    }
    
    func getMovie(for indexPath: IndexPath) -> Movie? {
        guard let moviesCount = movieListData?.movies.count else {return nil}
        guard moviesCount > indexPath.row else {return nil}
        return movieListData?.movies[indexPath.row]
    }
    
    func fetchMovies( dataFetched: @escaping ([Movie]?) -> () ) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url){(data,response,err) in
            guard let data = data else { return }
            print(String(data: data, encoding: String.Encoding.utf8))
            do {
                self.movieListData = try JSONDecoder().decode(MovieList.self, from: data)
                dataFetched(self.movieListData?.movies)
                
            }catch let jsonErr {
                print("Error serializing json:",jsonErr)
            }
            
            }.resume()
    }
}
