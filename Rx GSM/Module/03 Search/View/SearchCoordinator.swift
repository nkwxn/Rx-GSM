//
//  SearchCoordinator.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation
import UIKit

protocol SearchFlow: AnyObject {
    func coordinateToPhones()
}

class SearchCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController()
        searchViewController.coordinator = self
        
        navigationController?.pushViewController(searchViewController, animated: false)
    }
}
