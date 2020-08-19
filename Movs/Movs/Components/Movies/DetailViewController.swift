
import UIKit
import CoreData

final class DetailViewController: UIViewController {
    
    var movie: Movie!
    var favorite: FavoritesCD!
    var genreManager = GenreManager.shared
    var isFavorite: Bool!
    
    private let detailView: DetailView = {
        let view = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(movie: Movie, isFavorite: Bool ) {
        self.movie = movie
        self.isFavorite = isFavorite
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        detailView.configure(movie: movie, isFavorite: isFavorite, genreLabel: genreManager.getGenres(ids: movie.genreIDS))
    }
    
    func didFavorite(){
            print("cheguei")
            if !isFavorite {
                if favorite == nil {
                    favorite = FavoritesCD(context: context)
                }
                favorite.movieId = Int32(movie.id)
                favorite.image = movie.posterPath
                favorite.name = movie.title
                favorite.overview = movie.overview
                favorite.year = String(movie.releaseDate.dropLast(6))
                do {
                    try context.save()
    //                let image = UIImage(named: "favorite_full_icon") as UIImage?
    ////                favoriteButton.setBackgroundImage(image, for: .normal)
                    DispatchQueue.main.async {
    //                    self.collectionView.reloadData()
                        self.reloadInputViews()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
}

extension DetailViewController: CodeView {
    func setupAdditionalConfiguration(){
        self.title = "Movie"
        self.view.backgroundColor = .white
        navigationController!.navigationBar.tintColor = .black
    }
    
    func buildViewHierarchy() {
        self.view.addSubview(detailView)
    }
    
    func setupConstraints() {
        detailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        detailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        detailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        detailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
}
