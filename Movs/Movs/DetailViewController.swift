////
////  DetailViewController.swift
////  Movs
////
////  Created by Gustavo Evangelista on 04/06/2019.
////  Copyright © 2019 Gustavo. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class DetailViewController: UIViewController {
//    
//    var backdrop: UIImageView!
//    var titleLabel: UILabel!
//    var favoriteButton: UIButton!
//    var yearLabel: UILabel!
//    var genreLabel: UILabel!
//    var overviewTextView: UITextView!
//    var isFavorite: Bool!
//    
//    var movie: Movie!
//    var favorite: FavoritesCD!
//    var imageManager = ImageManager.shared
//    var genreManager = GenreManager.shared
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        backdrop = UIImageView()
//        backdrop.image = imageManager.backdropImage(backdropPath: movie.backdrop_path)
//        backdrop.contentMode = .scaleAspectFit
//        
//        titleLabel = UILabel()
//        titleLabel.text = movie.title
//        titleLabel.textColor = .black
//        titleLabel.font = UIFont(name: "System", size: 24)
//        titleLabel.numberOfLines = 0
//        
//        favoriteButton = UIButton(type: .system)
//        if isFavorite == true {
//            favoriteButton.setBackgroundImage(UIImage(named: "favorite_full_icon") as UIImage?, for: .normal)
//        } else {
//            favoriteButton.setBackgroundImage(UIImage(named: "favorite_empty_icon") as UIImage?, for: .normal)
//        }
//        favoriteButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        
//        yearLabel = UILabel()
//        yearLabel.text = String(movie.release_date.dropLast(6))
//        yearLabel.textColor = .black
//        yearLabel.font = UIFont(name: "System", size: 24)
//        
//        genreLabel = UILabel()
//        genreLabel.text = genreManager.getGenres(ids: movie.genre_ids)
//        genreLabel.textColor = .black
//        genreLabel.font = UIFont(name: "System", size: 24)
//        genreLabel.numberOfLines = 0
//        
//        overviewTextView = UITextView()
//        overviewTextView.text = movie.overview
//        overviewTextView.font = UIFont.systemFont(ofSize: 17)
//        overviewTextView.textColor = .black
//        
//        view.addSubview(titleLabel)
//        view.addSubview(backdrop)
//        view.addSubview(favoriteButton)
//        view.addSubview(yearLabel)
//        view.addSubview(genreLabel)
//        view.addSubview(overviewTextView)
//        
//        labelConstraint()
//        backdropConstraint()
//        favoriteButtonConstraint()
//        yearConstraint()
//        genreConstraint()
//        overviewConstraint()
//    }
//    
//    @objc func buttonClicked(sender : UIButton){
//        if !isFavorite {
//            if favorite == nil {
//                favorite = FavoritesCD(context: context)
//            }
//            favorite.movieId = Int32(movie.id)
//            favorite.image = movie.poster_path
//            favorite.name = movie.title
//            favorite.overview = movie.overview
//            favorite.year = String(movie.release_date.dropLast(6))
//            
//            do {
//                try context.save()
//                let image = UIImage(named: "favorite_full_icon") as UIImage?
//                favoriteButton.setBackgroundImage(image, for: .normal)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func backdropConstraint(){
//        backdrop.translatesAutoresizingMaskIntoConstraints = false
//        backdrop.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        backdrop.heightAnchor.constraint(equalToConstant: 210).isActive = true
//        backdrop.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        backdrop.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
//        backdrop.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
//    }
//    
//    func labelConstraint(){
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.topAnchor.constraint(equalTo: backdrop.bottomAnchor, constant: 15).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -5).isActive = true //direita
//        titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
//    }
//    
//    func favoriteButtonConstraint() {
//        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
//        favoriteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        favoriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        favoriteButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
//        favoriteButton.topAnchor.constraint(equalTo: backdrop.bottomAnchor, constant: 15).isActive = true
//    }
//    
//    func yearConstraint() {
//        yearLabel.translatesAutoresizingMaskIntoConstraints = false
//        yearLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
//        yearLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
//        yearLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
//    }
//    
//    func genreConstraint() {
//        genreLabel.translatesAutoresizingMaskIntoConstraints = false
//        genreLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 15).isActive = true
//        genreLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
//        genreLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
//    }
//    
//    func overviewConstraint(){
//        overviewTextView.translatesAutoresizingMaskIntoConstraints = false
//        overviewTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
//        overviewTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
//        overviewTextView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 15).isActive = true
//        overviewTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
//    }
//    
//}
