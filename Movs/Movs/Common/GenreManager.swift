
import Foundation

final class GenreManager {
    
    static let shared = GenreManager()
    var restManager = RestManager.shared
    
    private init(){
    }
    
    var dictionaryGenres = [Int: String]()
    
    func getGenreApi(){
        restManager.loadGenre(onComplete: { (genres) in
            self.dictionaryGenres = genres
        }) { (error) in
            switch error {
            case .invalidJson:
                print("JSON Inválido")
            case .url:
                print("url")
            case .taskError(let error):
                print(error)
            case .noResponse:
                print("Response")
            case .noData:
                print("sem dados")
            case .responseStatusCode(let code):
                print(code)
            }
        }
    }
    
    func getGenres(ids: [Int]) -> String {
        var genresMovie = ""
        for id in ids {
            genresMovie = genresMovie + dictionaryGenres[id]! + ", "
        }
        return String(genresMovie.dropLast(2))
    }
    
    
}
