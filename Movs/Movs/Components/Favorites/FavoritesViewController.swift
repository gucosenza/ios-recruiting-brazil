import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    let favoritesView = FavoritesView()
    var favoritesDataSource: FavoritesDataSource?
    var fetchedResultController: NSFetchedResultsController<FavoritesCD>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "Favorites"
        
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "Color1")
//        navigationItem.searchController = UISearchController(searchResultsController: nil)
//        navigationItem.hidesSearchBarWhenScrolling = false
//
//        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: nil, action: nil)
//        filterButton.tintColor = .black
//        self.navigationItem.rightBarButtonItem  = filterButton
        
        loadFavorites()
        
        favoritesView.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoritesDataSource.identifier)
        guard let favorites = fetchedResultController.fetchedObjects else { return }
        favoritesDataSource = FavoritesDataSource(favorites: favorites)
        favoritesView.tableView.dataSource = favoritesDataSource
        favoritesView.tableView.separatorStyle = .none

        favoritesView.tableView.reloadData()
    }
    
    override func loadView() {
        self.view = favoritesView
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

}

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .delete:
            if let indexPath = indexPath{
                favoritesView.tableView.deleteRows(at: [indexPath], with: .fade)
                loadFavorites()
                print("deleta tableview")
            }
        default:
            loadFavorites()
            favoritesView.tableView.reloadData()
        }
    }
}









