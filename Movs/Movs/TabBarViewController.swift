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

        let moviesCollectionViewController = MoviesCollectionViewController()
        moviesCollectionViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        let favoritesTableViewController = FavoritesTableViewController()
        favoritesTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let viewControllerList = [ moviesCollectionViewController, favoritesTableViewController ]
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }
}
