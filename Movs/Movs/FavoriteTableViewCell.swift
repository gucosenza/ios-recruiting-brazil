//
//  FavoriteTableViewCell.swift
//  Movs
//
//  Created by gustavo.cosenza on 04/06/19.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

//    // MARK: Outlets
//    private lazy var viewTicket: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .white
////        view.layer.cornerRadius = 8.0
////        view.accessibilityIdentifier = "viewCellTicket"
//        view.translatesAutoresizingMaskIntoConstraints = false
//        self.viewTicket.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
//        self.viewTicket.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
//        self.viewTicket.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        self.viewTicket.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
//        return view
//    }()
//
//    var titleLabel: UILabel!
    
//    @IBOutlet weak var posterImage: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var yearLabel: UILabel!
//    @IBOutlet weak var overviewLabel: UILabel!
//
//    var imageManager = ImageManager.shared

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with favorite:String) {
        textLabel!.textColor = .red
        textLabel!.font = UIFont(name:"Helvetica-Bold", size:12.0)
        textLabel!.textAlignment = .center
        textLabel!.text = favorite
        
//        titleLabel = UILabel()
//        titleLabel.textColor = .black
//        titleLabel.font = UIFont(name: "System", size: 24)
//        titleLabel.numberOfLines = 0
//        self.addSubview(viewTicket)
//        self.viewTicket.addSubview(titleLabel)

//
//        titleLabel.text = favorite.name
//        yearLabel.text = favorite.year
//        overviewLabel.text = favorite.overview
//        posterImage.image = imageManager.posterImage(poster_path: favorite.image!)
    }

}
