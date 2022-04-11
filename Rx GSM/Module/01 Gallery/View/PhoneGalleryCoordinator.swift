//
//  PhoneGalleryCoordinator.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation
import UIKit

protocol PhoneGalleryFlow: AnyObject {
    func coordinateToPhoneSpec(phoneName: String, slug: String)
}

class PhoneGalleryCoordinator: Coordinator, PhoneGalleryFlow {
    let brand: Brand?
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController, brand: Brand? = nil) {
        self.navigationController = navigationController
        self.brand = brand
    }
    
    func start() {
        let phoneGalleryViewController = PhoneGalleryViewController()
        if let brand = brand {
            phoneGalleryViewController.title = brand.brandName
            phoneGalleryViewController.viewModel = PhoneGalleryViewModel(with: brand)
            
            phoneGalleryViewController.navigationItem.largeTitleDisplayMode = .never
        } else {
            phoneGalleryViewController.title = "New Phones"
            phoneGalleryViewController.viewModel = PhoneGalleryViewModel()
        }
        phoneGalleryViewController.coordinator = self
        
        navigationController?.pushViewController(phoneGalleryViewController, animated: brand != nil)
    }
    
    func coordinateToPhoneSpec(phoneName: String, slug: String) {
        let phoneSpecCoordinator = PhoneSpecCoordinator(navigationController: navigationController, phoneName: phoneName, slug: slug)
        phoneSpecCoordinator.start()
    }
}
