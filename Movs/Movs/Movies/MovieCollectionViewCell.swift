//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Gustavo Evangelista on 04/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var imageManager = ImageManager.shared
    
    private lazy var viewCell: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(named: "Color2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var favoriteImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Color1")
        label.font = UIFont(name: "System", size: 17)
        label.numberOfLines = 1
        return label
    }()

    func configure(movie: Movie, favorite: Bool) {
        posterImage.image = imageManager.posterImage(poster_path: movie.poster_path)
        titleLabel.text = movie.title
        if favorite == true {
            favoriteImage.image = UIImage(named: "favorite_full_icon") as UIImage?
        } else{
            favoriteImage.image = UIImage(named: "favorite_gray_icon") as UIImage?
        }
        
        self.addSubview(viewCell)
        self.viewCell.addSubview(posterImage)
        self.viewCell.addSubview(titleLabel)
        self.viewCell.addSubview(favoriteImage)
        
        posterConstraint()
        titleConstraint()
        favoriteConstraint()
    }
    
    func posterConstraint(){
        posterImage.centerXAnchor.constraint(equalTo: self.viewCell.centerXAnchor).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 278).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: 185).isActive = true
        posterImage.topAnchor.constraint(equalTo: self.viewCell.topAnchor, constant: 0).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: self.viewCell.leadingAnchor, constant: 0).isActive = true //esquerda
        posterImage.trailingAnchor.constraint(equalTo: self.viewCell.trailingAnchor, constant: 0).isActive = true //direita
    }
    func titleConstraint(){
        titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: 0).isActive = true //direita
        titleLabel.leadingAnchor.constraint(equalTo: self.viewCell.leadingAnchor, constant: 0).isActive = true //esquerda
        titleLabel.bottomAnchor.constraint(equalTo: self.viewCell.bottomAnchor, constant: 0).isActive = true
    }
    func favoriteConstraint(){
        favoriteImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteImage.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 0).isActive = true
        favoriteImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true //esquerda
        favoriteImage.trailingAnchor.constraint(equalTo: self.viewCell.trailingAnchor, constant: 0).isActive = true //direita
        favoriteImage.bottomAnchor.constraint(equalTo: self.viewCell.bottomAnchor, constant: 0).isActive = true
    }
}
