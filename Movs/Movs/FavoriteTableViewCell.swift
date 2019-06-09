//
//  FavoriteTableViewCell.swift
//  Movs
//
//  Created by gustavo.cosenza on 04/06/19.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    var imageManager = ImageManager.shared
    
    private lazy var viewCell: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Color2")
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Color2")
        label.font = UIFont(name: "System", size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Color2")
        label.font = UIFont(name: "System", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with favorite:FavoritesCD) {
        posterImage.image = imageManager.posterImage(poster_path: favorite.image!)
        titleLabel.text = favorite.name
        yearLabel.text = favorite.year
        overviewLabel.text = favorite.overview
        
        self.addSubview(viewCell)
        self.viewCell.addSubview(posterImage)
        self.viewCell.addSubview(titleLabel)
        self.viewCell.addSubview(yearLabel)
        self.viewCell.addSubview(overviewLabel)
        
        cellConstraint()
        posterConstraint()
        titleConstraint()
        yearConstraint()
        overviewConstraint()
        
    }

    func cellConstraint(){
        self.viewCell.translatesAutoresizingMaskIntoConstraints = false
        self.viewCell.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.viewCell.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        self.viewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        self.viewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        self.viewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
    }
    func posterConstraint(){
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        posterImage.topAnchor.constraint(equalTo: self.viewCell.topAnchor, constant: 0).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: self.viewCell.leadingAnchor, constant: 0).isActive = true //esquerda
        posterImage.bottomAnchor.constraint(equalTo: self.viewCell.bottomAnchor, constant: 0).isActive = true
    }
    
    func titleConstraint(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.viewCell.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10).isActive = true //esquerda
        titleLabel.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor, constant: 5).isActive = true //direita
        titleLabel.bottomAnchor.constraint(equalTo: overviewLabel.topAnchor, constant: 5).isActive = true
    }
    func yearConstraint(){
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        yearLabel.topAnchor.constraint(equalTo: self.viewCell.topAnchor, constant: 5).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true //esquerda
        yearLabel.trailingAnchor.constraint(equalTo: self.viewCell.trailingAnchor, constant: 0).isActive = true //direita
    }
    
    func overviewConstraint(){
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10).isActive = true //esquerda
        overviewLabel.trailingAnchor.constraint(equalTo: self.viewCell.trailingAnchor, constant: 0).isActive = true //direita
        overviewLabel.bottomAnchor.constraint(equalTo: self.viewCell.bottomAnchor, constant: 0).isActive = true
    }

}
