
import Foundation

struct Config {
    
    static var apiKey: String {
        guard let value:String = Bundle.main.infoDictionary?["apiKey"] as? String else {return "erro"}
        return value
    }
    
    static var basePath: String {
        guard let value:String = Bundle.main.infoDictionary?["basePath"] as? String else {return "erro"}
        return value
    }
    
    static var posterPath: String {
        guard let value:String = Bundle.main.infoDictionary?["posterPath"] as? String else {return "erro"}
        return value
    }
    
    static var backdropPath: String {
        guard let value:String = Bundle.main.infoDictionary?["backdropPath"] as? String else {return "erro"}
        return value
    }
    
}
