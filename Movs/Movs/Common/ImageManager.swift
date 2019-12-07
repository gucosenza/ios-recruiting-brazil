

import UIKit

final class ImageManager {
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    private let posterPath = Config.posterPath
    private let backdropPath = Config.backdropPath
    
    func posterImage (poster_path: String) -> UIImage {
        let url = URL(string: posterPath + poster_path)!
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: poster_path as AnyObject)
                
                if let imageFromCache = imageCache.object(forKey: poster_path as AnyObject) as? UIImage {
                    return imageFromCache
                }
            }
        }
        return UIImage(named: "no-image-found-360x260.png")!
    }
    
    func backdropImage(backdropPath: String) -> UIImage {
        if backdropPath != "semfoto"{
            let url = URL(string: self.backdropPath + backdropPath)!
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: backdropPath as AnyObject)
                    
                    if let imageFromCache = imageCache.object(forKey: backdropPath as AnyObject) as? UIImage {
                        return imageFromCache
                    }
                    
                }
            }
        }
        return UIImage(named: "no-image-found-360x260.png")!
    }
}
