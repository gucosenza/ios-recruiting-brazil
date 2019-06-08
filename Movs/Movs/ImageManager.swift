//
//  ImageManager.swift
//  MovsTests
//
//  Created by Gustavo Evangelista on 07/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit

final class ImageManager {
    
    static let shared = ImageManager()
    
    private init(){
    }
    
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
        let url = URL(string: self.backdropPath + backdropPath)!
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: backdropPath as AnyObject)
                
                if let imageFromCache = imageCache.object(forKey: backdropPath as AnyObject) as? UIImage {
                    return imageFromCache
                }
                
            }
        }
        return UIImage(named: "no-image-found-360x260.png")!
    }
}
