//
//  RestManager.swift
//  MovsTests
//
//  Created by Gustavo Evangelista on 07/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//


import Foundation

enum GenreError {
    case url
    case taskError (error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}

final class RestManager {
    
    static let shared = RestManager()
    
    private init(){
        
    }
    
    var dictionaryGenres = [Int: String]()
    
    private let basePath = Config.basePath
    private let apiKey = Config.apiKey
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["content-type":"application/json;charset=utf-8"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    let session = URLSession(configuration: configuration)
    
    func loadGenre(onComplete: @escaping (Dictionary<Int, String>) -> Void, onError: @escaping (GenreError) -> Void) {
        
        let urlGenres = basePath + "/genre/movie/list?language=en-US&api_key=" + apiKey
        guard let url = URL(string: urlGenres ) else {
            onError(.url)
            return
        }
        
        //monta a requisicao
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            // se nao tiver erro no aplicativo para fazer requisicao
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                // se o status da requisicao deu certo (200)
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do{
                        let genresApi = try JSONDecoder().decode(GenresApi.self, from: data)
                        
                        for genre in genresApi.genres {
                            self.dictionaryGenres[genre.id] = genre.name
                        }
                        
                        onComplete(self.dictionaryGenres)
                        
                    }catch {
                        onError(.invalidJson)
                    }
                }else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            }else {
                onError(.taskError(error: error!))
            }
        }
        //executa a requisicao
        dataTask.resume()
    }
    
    func loadMovies(onComplete: @escaping (MoviesApi) -> Void, onError: @escaping (GenreError) -> Void, page: Int) {
        
        let urlMovies = basePath + "/movie/popular?page=" + String(page) + "&language=en-US&api_key=" + apiKey
        
        guard let url = URL(string: urlMovies ) else {
            onError(.url)
            return
        }
        print("url: " + urlMovies)
        //monta a requisicao
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            // se nao tiver erro no aplicativo para fazer requisicao
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                // se o status da requisicao deu certo (200)
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do{
                        let moviesApi = try JSONDecoder().decode(MoviesApi.self, from: data)
                        onComplete(moviesApi)
                        
                    }catch {
                        onError(.invalidJson)
                    }
                }else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            }else {
                onError(.taskError(error: error!))
            }
        }
        //executa a requisicao
        dataTask.resume()
    }
}
