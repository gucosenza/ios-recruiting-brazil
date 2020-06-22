

import Foundation

final class RestManager {
    
    static let shared = RestManager()
    
    private let network = Network()
    
    var dictionaryGenres = [Int: String]()
    
    private let basePath = Config.basePath
    private let apiKey = Config.apiKey
    
    func loadGenre(onComplete: @escaping (Dictionary<Int, String>) -> Void, onError: @escaping (NetworkError) -> Void) {
        
        let urlGenres = basePath + "/genre/movie/list?language=en-US&api_key=" + apiKey
        guard let url = URL(string: urlGenres ) else {
            onError(.url)
            return
        }
        
        network.loadRest(url: url) { (data, error) in
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
        }
    }
    
    func loadMovies(onComplete: @escaping (MoviesApi) -> Void, onError: @escaping (NetworkError) -> Void, page: Int) {
        
        let urlMovies = basePath + "/movie/popular?page=" + String(page) + "&language=en-US&api_key=" + apiKey
        guard let url = URL(string: urlMovies ) else {
            onError(.url)
            return
        }
        print("url: " + urlMovies)
        
        network.loadRest(url: url) { (data, error) in
            guard let data = data else {return}
               do{
                   let moviesApi = try JSONDecoder().decode(MoviesApi.self, from: data)
                   onComplete(moviesApi)
                   print("Requisiçao movies feita!!")

               }catch {
                   print(error)
                    onError(.invalidJson)
               }
        }
    }
}
