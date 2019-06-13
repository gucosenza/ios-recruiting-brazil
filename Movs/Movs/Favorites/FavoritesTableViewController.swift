//
//  FavoritesTableViewController.swift
//  Movs
//
//  Created by Gustavo Evangelista on 04/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<FavoritesCD>!
    var noResultsLabel = UILabel()
    
    let cellID = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
        
        self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.tableView.separatorStyle = .none
        
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "Color1")
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        let button1 = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: Selector("action"))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: nil, action: nil)
        filterButton.tintColor = .black
        self.navigationItem.rightBarButtonItem  = filterButton
        
        
        noResultsLabel.text = "Você não possui favoritos"
        noResultsLabel.textAlignment = .center
        
        loadFavorites()
    }
    
    func loadFavorites() {
        let fetchRequest: NSFetchRequest<FavoritesCD> = FavoritesCD.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self as NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? noResultsLabel : nil
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! FavoriteTableViewCell

        guard let favorite = fetchedResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        cell.prepare(with: favorite)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let favorite = fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            do {
                try context.delete(favorite)
                print("deleta contexto")
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
}


extension FavoritesTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
                print("deleta tableview")
            }
        default:
            tableView.reloadData()
        }
    }
}
