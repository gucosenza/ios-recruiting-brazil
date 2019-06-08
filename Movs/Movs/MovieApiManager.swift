//
//  MovieApiManager.swift
//  Movs
//
//  Created by Gustavo Evangelista on 07/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

final class MovieApiManager {
    
    static let shared = MovieApiManager()
    
    var restManager = RestManager.shared
    private var page = 1
    
    var movies = [Movie]()
    var totalMovies:Int = 0
    var loadingMovies = false
    
    private init(){
    }
    
    func getMovieApi(){
        loadingMovies = true
        restManager.loadMovies(onComplete: { (moviesApi) in
            self.totalMovies = moviesApi.total_results
            for movie in moviesApi.results {
                self.movies.append(movie)
            }
            self.page = self.page + 1
        }, onError: { (error) in
            print("Deu erro ao carregar os filmes")
        }, page: page)
        loadingMovies = false
    }
    
}
