import UIKit

class FavoritesDataSource: NSObject, UITableViewDataSource{
    
    var noResultsLabel = UILabel()
    let favorites: [FavoritesCD]
    static let identifier = "identifier"

    init(favorites: [FavoritesCD]) {
        self.favorites = favorites
        super.init()
        
        noResultsLabel.text = "Você não possui favoritos"
        noResultsLabel.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = favorites.count
        tableView.backgroundView = count == 0 ? noResultsLabel : nil
        return count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesDataSource.identifier, for: indexPath) as! FavoriteTableViewCell
        cell.prepare(with: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(favorites[indexPath.row])
        }
    }
    
}
