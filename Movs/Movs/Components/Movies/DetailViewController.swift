
import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var movie: Movie!
    var favorite: FavoritesCD!
    var imageManager = ImageManager()
    var genreManager = GenreManager.shared
    var isFavorite: Bool!
    
    private lazy var backdrop: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var overviewTextView: UITextView = {
        let overview = UITextView()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = UIFont.systemFont(ofSize: 17)
        overview.textColor = .black
        overview.isEditable = false
        return overview
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
        
        backdrop.image = imageManager.backdropImage(backdropPath: movie.backdropPath ?? "semfoto")
        titleLabel.text = movie.title
        if isFavorite == true {
            favoriteButton.setBackgroundImage(UIImage(named: "favorite_full_icon") as UIImage?, for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(named: "favorite_empty_icon") as UIImage?, for: .normal)
        }
        yearLabel.text = String(movie.releaseDate.dropLast(6))
        genreLabel.text = genreManager.getGenres(ids: movie.genreIDS)
        overviewTextView.text = movie.overview
        
       
    }
    
    @objc func buttonClicked(sender : UIButton){
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
                let image = UIImage(named: "favorite_full_icon") as UIImage?
                favoriteButton.setBackgroundImage(image, for: .normal)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension DetailViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(backdrop)
        view.addSubview(favoriteButton)
        view.addSubview(yearLabel)
        view.addSubview(genreLabel)
        view.addSubview(overviewTextView)
    }
    
    func setupConstraints() {
        labelConstraint()
        backdropConstraint()
        favoriteButtonConstraint()
        yearConstraint()
        genreConstraint()
        overviewConstraint()
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Movie"
        self.view.backgroundColor = .white
        navigationController!.navigationBar.tintColor = .black
    }
    
    func backdropConstraint(){
        backdrop.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        backdrop.heightAnchor.constraint(equalToConstant: 210).isActive = true
        backdrop.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backdrop.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
        backdrop.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
    }
    
    func labelConstraint(){
        titleLabel.topAnchor.constraint(equalTo: backdrop.bottomAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -5).isActive = true //direita
        titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
    }
    
    func favoriteButtonConstraint() {
        favoriteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        favoriteButton.topAnchor.constraint(equalTo: backdrop.bottomAnchor, constant: 15).isActive = true
    }
    
    func yearConstraint() {
        yearLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
        yearLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
    }
    
    func genreConstraint() {
        genreLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 15).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
        genreLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
    }
    
    func overviewConstraint(){
        overviewTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        overviewTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        overviewTextView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 15).isActive = true
        overviewTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
    }
}
