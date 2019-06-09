//
//  UITabBarViewController.swift
//  Movs
//
//  Created by Gustavo Evangelista on 04/06/2019.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tabBar.backgroundColor = UIColor(named: "Color1")
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.barTintColor = UIColor(named: "Color1")

        let moviesCollectionViewController = MoviesCollectionViewController()
        moviesCollectionViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
        
        let favoritesTableViewController = FavoritesTableViewController()
        favoritesTableViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), tag: 1)
        
        let viewControllerList = [ moviesCollectionViewController, favoritesTableViewController ]
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }
}
