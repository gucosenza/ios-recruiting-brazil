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
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
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
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        loadFavorites()
        movieApiManager.getMovieApi()
        genreManager.getGenreApi()
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        loadFavorites()
        self.collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.backgroundView = movieApiManager.movies.count == 0 ? noResultsLabel : nil
        return movieApiManager.movies.count
//        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.configure(movie: movieApiManager.movies[indexPath.row],favorite: favoriteIds.contains(movieApiManager.movies[indexPath.row].id))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let index = collectionView.indexPathsForSelectedItems?.first {
            let detailController = DetailViewController(movie: movieApiManager.movies[index.row], isFavorite: favoriteIds.contains(movieApiManager.movies[index.row].id))
            self.navigationController?.pushViewController(detailController, animated: true)
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        let detailController = DetailViewController()
//        if let index = collectionView.indexPathsForSelectedItems?.first {
//            detailController.movie = movieApiManager.movies[indexPath.row]
//            detailController.isFavorite = favoriteIds.contains(movieApiManager.movies[index.row].id)
//        }
//        return true
//    }
 

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
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

}
