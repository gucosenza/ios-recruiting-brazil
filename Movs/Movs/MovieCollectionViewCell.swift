//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Gustavo Evangelista on 04/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var posterImage: UIImageView!
    var favoriteImage: UIImageView!
    var titleLabel: UILabel!
    
    var imageManager = ImageManager.shared

    func configure(movie: Movie, favorite: Bool) {
        
        self.backgroundColor = UIColor(named: "Color2")
        
        posterImage = UIImageView()
        posterImage.backgroundColor = .red
        posterImage.image = imageManager.posterImage(poster_path: movie.poster_path)
        posterImage.contentMode = .scaleAspectFill

        titleLabel = UILabel()
        titleLabel.text = movie.title
        titleLabel.textColor = UIColor(named: "Color1")
        titleLabel.font = UIFont(name: "System", size: 17)
        titleLabel.numberOfLines = 1
        
        
        favoriteImage = UIImageView()
        if favorite == true {
            favoriteImage.image = UIImage(named: "favorite_full_icon") as UIImage?
        } else{
            favoriteImage.image = UIImage(named: "favorite_gray_icon") as UIImage?
        }
        favoriteImage.contentMode = .scaleToFill
        
        self.addSubview(posterImage)
        self.addSubview(titleLabel)
        self.addSubview(favoriteImage)
        
        cellConstraint()
        posterConstraint()
        titleConstraint()
        favoriteConstraint()
    }
    
    func cellConstraint(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 185).isActive = true
        self.heightAnchor.constraint(equalToConstant: 308).isActive = true
    }
    
    func posterConstraint(){
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 278).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: 185).isActive = true
        posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true //esquerda
        posterImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true //direita
    }
    func titleConstraint(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: 0).isActive = true //direita
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true //esquerda
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    func favoriteConstraint(){
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteImage.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 0).isActive = true
        favoriteImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true //esquerda
        favoriteImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true //direita
        favoriteImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
