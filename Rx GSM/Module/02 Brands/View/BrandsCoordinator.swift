//
//  BrandsCoordinator.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation
import UIKit

protocol BrandsFlow: AnyObject {
    func coordinateToPhones(with chosenBrand: Brand)
}

class BrandsCoordinator: Coordinator, BrandsFlow {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let brandsViewController = BrandsViewController()
        brandsViewController.coordinator = self
        
        navigationController?.pushViewController(brandsViewController, animated: false)
    }
    
    func coordinateToPhones(with chosenBrand: Brand) {
        print("Should push navigation with brand slug")
        let coordinator = PhoneGalleryCoordinator(navigationController: navigationController!, brand: chosenBrand)
        coordinator.start()
    }
}
