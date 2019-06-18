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
    var movieApiManager = MovieApiManager.shared
    var fetchedResultController: NSFetchedResultsController<FavoritesCD>!
    
    var favoriteIds = [Int]()
    var noResultsLabel = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies = [ Movie ] ()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 308
        layout.itemSize.width = 185
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset.bottom = 15
        layout.sectionInset.left = 15
        layout.sectionInset.right = 15
        layout.sectionInset.top = 15
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        noResultsLabel.text = "Não existe filme para ser exibido"
        noResultsLabel.textAlignment = .center
        
        self.collectionView.backgroundColor = UIColor(named: "Color4")
        self.title = "Movies"
        
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "Color1")
//        navigationItem.searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false

        // Register cell classes
        self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        loadFavorites()
        movieApiManager.getMovieApi()
        genreManager.getGenreApi()
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFavorites()
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        }else{
            collectionView.backgroundView = movieApiManager.movies.count == 0 ? noResultsLabel : nil
            return movieApiManager.movies.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        if isFiltering() {
            cell.configure(movie: filteredMovies[indexPath.row],favorite: favoriteIds.contains(filteredMovies[indexPath.row].id))
        } else {
            cell.configure(movie: movieApiManager.movies[indexPath.row],favorite: favoriteIds.contains(movieApiManager.movies[indexPath.row].id))
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
                let detailController = DetailViewController(movie: movieApiManager.movies[index.row], isFavorite: favoriteIds.contains(movieApiManager.movies[index.row].id))
                self.navigationController?.pushViewController(detailController, animated: true)
            }
        }
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
        filteredMovies = movieApiManager.movies.filter({( movie : Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        
        collectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}

extension MoviesCollectionViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
