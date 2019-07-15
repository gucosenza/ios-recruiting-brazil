//
//  MoviesCollectionViewController.swift
//  Movs
//
//  Created by Gustavo Evangelista on 04/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var restManager = RestManager.shared
    var genreManager = GenreManager.shared
    var fetchedResultController: NSFetchedResultsController<FavoritesCD>!
    
    var favoriteIds = [Int]()
    var noResultsLabel = UILabel()
    var errorRestLabel = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies = [ Movie ] ()
    
    private var page = 1
    var movies = [Movie]()
    var totalMovies:Int = 0
    var loadingMovies = false
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noResultsLabel.text = "Não existe filme para ser exibido"
        noResultsLabel.textAlignment = .center
        errorRestLabel.text = "Nao foi possivel recuperar os filmes"
        errorRestLabel.textAlignment = .center
        
        self.collectionView.backgroundColor = UIColor(named: "Color4")
        self.title = "Movies"
        
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "Color1")
//        navigationItem.searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        searchController.searchBar.barTintColor = .black
        UISearchBar.appearance().tintColor = UIColor.black
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false

        // Register cell classes
        self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        self.loadFavorites()
        self.getMovieApi()
        self.genreManager.getGenreApi()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getMovieApi(){
        let spinnerView = UIView.init(frame: self.view.bounds)
//        let spinnerView = UIView(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        
        spinnerView.addSubview(ai)
        self.view.addSubview(spinnerView)
        
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        ai.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        loadingMovies = true
        restManager.loadMovies(onComplete: { (moviesApi) in
            self.totalMovies = moviesApi.totalResults
            for movie in moviesApi.results {
                self.movies.append(movie)
            }
            self.page = self.page + 1
            
            DispatchQueue.main.async {
                spinnerView.removeFromSuperview()
                self.collectionView.reloadData()
            }
        }, onError: { (error) in
            print("Deu erro ao carregar os filmes")
            DispatchQueue.main.async {
                spinnerView.removeFromSuperview()
                self.collectionView.backgroundView = self.errorRestLabel
            }
        }, page: page)
        loadingMovies = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavorites()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchBarIsEmpty(){
            collectionView.backgroundView = nil
        }
        if isFiltering() {
            collectionView.backgroundView = filteredMovies.count == 0 ? noResultsLabel : nil
            return filteredMovies.count
        }else{
//            collectionView.backgroundView = movies.count == 0 ? noResultsLabel : nil
            return movies.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        if isFiltering() {
            cell.configure(movie: filteredMovies[indexPath.row],favorite: favoriteIds.contains(filteredMovies[indexPath.row].id))
        } else {
            cell.configure(movie: movies[indexPath.row],favorite: favoriteIds.contains(movies[indexPath.row].id))
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFiltering() {
            if let index = collectionView.indexPathsForSelectedItems?.first {
                let detailController = DetailViewController(movie: filteredMovies[index.row], isFavorite: favoriteIds.contains(filteredMovies[index.row].id))
                self.navigationController?.pushViewController(detailController, animated: true)
            }
        } else {
            if let index = collectionView.indexPathsForSelectedItems?.first {
                let detailController = DetailViewController(movie: movies[index.row], isFavorite: favoriteIds.contains(movies[index.row].id))
                self.navigationController?.pushViewController(detailController, animated: true)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let border = ((self.view.bounds.width - (185*2)) / 3)
        return UIEdgeInsets(top: 10, left: border, bottom: 0, right: border)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 185, height: 308)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ((self.view.bounds.width - (185*2)) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ((self.view.bounds.width - (185*2)) / 3)
    }
    
    func loadFavorites(){
        let fetchRequest: NSFetchRequest<FavoritesCD> = FavoritesCD.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self as? NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        favoriteIds.removeAll()
        for favorite in (fetchedResultController.fetchedObjects)! {
            favoriteIds.append(Int(favorite.movieId))
        }
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = movies.filter({( movie : Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    // MARK: - Scroll Infinito
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        if indexPath.row == movieApiManager.movies.count - 10 && !movieApiManager.loadingMovies && movieApiManager.movies.count != movieApiManager.totalMovies{
//            print("carrega mais")
//            movieApiManager.getMovieApi()
//            print(movieApiManager.movies.count)
//            self.collectionView.reloadData()
//        }
//    }

}

extension MoviesCollectionViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
