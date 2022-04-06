//
//  BrandsCoordinator.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation
import UIKit

protocol BrandsFlow: AnyObject {
    func coordinateToPhones()
}

class BrandsCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let brandsViewController = BrandsViewController()
        brandsViewController.coordinator = self
        
        navigationController?.pushViewController(brandsViewController, animated: false)
    }
}
