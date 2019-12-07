import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var imageManager = ImageManager()
    
    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var favoriteImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(named: "Color1")
        label.font = UIFont(name: "System", size: 17)
        label.numberOfLines = 1
        return label
    }()

    func configure(movie: Movie, favorite: Bool) {
        contentView.backgroundColor = UIColor(named: "Color2")
        posterImage.image = imageManager.posterImage(poster_path: movie.posterPath)
        titleLabel.text = movie.title
        if favorite == true {
            favoriteImage.image = UIImage(named: "favorite_full_icon") as UIImage?
        } else{
            favoriteImage.image = UIImage(named: "favorite_gray_icon") as UIImage?
        }
        
        setupViews()
    }
}

extension MovieCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteImage)
    }
    
    func setupConstraints() {
        posterConstraint()
        titleConstraint()
        favoriteConstraint()
    }
    
    func posterConstraint(){
        posterImage.heightAnchor.constraint(equalToConstant: 278).isActive = true
        posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true //esquerda
        posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true //direita
    }
    func titleConstraint(){
        titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: 0).isActive = true //direita
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true //esquerda
        titleLabel.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: 0).isActive = true
    }
    func favoriteConstraint(){
        favoriteImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteImage.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 5).isActive = true
        favoriteImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true //esquerda
        favoriteImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true //direita
//        favoriteImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
}
