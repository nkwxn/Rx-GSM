//
//  TabBarCoordinator.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let pgNavigationController = UINavigationController()
        pgNavigationController.navigationBar.prefersLargeTitles = true
        pgNavigationController.tabBarItem = UITabBarItem(title: "Gallery", image: UIImage(systemName: "candybarphone"), tag: 0)
        let pgCoordinator = PhoneGalleryCoordinator(navigationController: pgNavigationController)
        
        let brandNavigationController = UINavigationController()
        brandNavigationController.tabBarItem = UITabBarItem(title: "Brands", image: UIImage(systemName: "star"), tag: 1)
        let brandCoordinator = BrandsCoordinator(navigationController: brandNavigationController)
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        tabBarController.viewControllers = [
            pgNavigationController,
            brandNavigationController,
            searchNavigationController
        ]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        coordinate(to: pgCoordinator)
        coordinate(to: brandCoordinator)
        coordinate(to: searchCoordinator)
    }
}
