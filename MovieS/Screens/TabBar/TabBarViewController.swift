//
//  TabBarViewController.swift
//  MovieS
//
//  Created by Selin Ersev on 16.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .blackBackgroundColor
        tabBar.tintColor = #colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.7019607843, alpha: 1)
        setUpTabBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    func setUpTabBar() {
        let searchController = createNavController(vc: HomeViewController(tabBarState: .search, genres: []), selected: "searchIcon.png", unselected: "searchIcon.png")
        let discoverController = createNavController(vc: DiscoverViewController(), selected: "discover.png", unselected: "discover.png")
    
        viewControllers = [searchController, discoverController]
        
        guard let items = tabBar.items else {return}
        
        for item in items{
            item.imageInsets = UIEdgeInsets(top: 4,left: 0,bottom: -4,right: 0)
        }
    }
}

extension UITabBarController {
    func createNavController(vc: UIViewController, selected: String, unselected: String) -> UINavigationController{
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: unselected)
        navController.tabBarItem.selectedImage = UIImage(named: selected)
        return navController
    }
}
