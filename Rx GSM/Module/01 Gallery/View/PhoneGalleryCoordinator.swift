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
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let phoneGalleryViewController = PhoneGalleryViewController()
        phoneGalleryViewController.coordinator = self
        
        navigationController?.pushViewController(phoneGalleryViewController, animated: false)
    }
    
    func coordinateToPhoneSpec(phoneName: String, slug: String) {
        let phoneSpecCoordinator = PhoneSpecCoordinator(navigationController: navigationController, phoneName: phoneName, slug: slug)
        phoneSpecCoordinator.start()
    }
}
