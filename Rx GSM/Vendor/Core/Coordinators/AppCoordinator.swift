//
//  AppCoordinator.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
//        let tabCoordinator = TabBarCoordinator(window: window)
        
//        coordinate(to: tabCoordinator)
    }
}
