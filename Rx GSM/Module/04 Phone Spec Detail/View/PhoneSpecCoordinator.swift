//
//  PhoneSpecCoordinator.swift
//  Rx GSM
//
//  Created by Nicholas on 28/03/22.
//

import Foundation
import UIKit

class PhoneSpecCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    let phoneName: String
    let slug: String
    
    init(navigationController: UINavigationController?, phoneName: String, slug: String) {
        self.navigationController = navigationController
        self.phoneName = phoneName
        self.slug = slug
    }
    
    func start() {
        let phoneSpecViewController = PhoneSpecViewController()
        phoneSpecViewController.title = phoneName
        phoneSpecViewController.coordinator = self
        phoneSpecViewController.viewModel = PhoneSpecViewModel()
        phoneSpecViewController.viewModel.fetchPhoneSpecData(phoneSlug: slug)
        navigationController?.pushViewController(phoneSpecViewController, animated: true)
    }
    
}
