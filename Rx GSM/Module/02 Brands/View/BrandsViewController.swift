//
//  BrandsViewController.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import UIKit

class BrandsViewController: BaseViewController {
    var viewModel = BrandsViewModel()
    var coordinator: BrandsCoordinator?
    
    lazy var brandSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

}
