import UIKit

class FavoritesView: UIView {
    
   let tableView = UITableView()
   
   override init(frame: CGRect) {
       super.init(frame: frame)
       
       addSubview(tableView)
       
       tableView.translatesAutoresizingMaskIntoConstraints = false
       tableView.separatorInset = UIEdgeInsets.zero
       
       NSLayoutConstraint.activate([
           tableView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
           tableView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
           tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
           tableView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
           ])
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
