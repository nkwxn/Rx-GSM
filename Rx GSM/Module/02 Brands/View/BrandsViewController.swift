//
//  BrandsViewController.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import UIKit
import RxSwift
import RxCocoa

class BrandsViewController: BaseViewController {
    var viewModel = BrandsViewModel()
    var coordinator: BrandsCoordinator?
    
    lazy var brandSearchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    
    lazy var brandsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableView")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.startAnimating()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrangeViews()
        bindData()
    }
    
    func arrangeViews() {
        self.title = "Brands"
        
        // Navigation Item Setup
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.searchController = brandSearchController
        
        view.addSubview(brandsTableView)
        view.addSubview(loadingIndicator)
        brandsTableView.frame = view.frame
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func bindData() {
        // Bind table view controller
        viewModel.isLoaded.bind(to: self.loadingIndicator.rx.isHidden).disposed(by: bag)
        
        viewModel.brandsList.bind(
            to: brandsTableView.rx.items(
                cellIdentifier: "tableView",
                cellType: UITableViewCell.self
            )
        ) { row, model, cell in
            var content = cell.defaultContentConfiguration()
            content.text = model.brandName
            content.secondaryText = "\(model.deviceCount) devices"
            
            cell.contentConfiguration = content
        }.disposed(by: bag)
        
        brandsTableView.rx.modelSelected(Brand.self).bind { [weak self] brand in
            self?.coordinator?.coordinateToPhones(with: brand)
        }.disposed(by: bag)
        
        brandsTableView.rx.itemSelected.bind { [weak self] indexPath in
            self?.brandsTableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: bag)
        
        // Bind search bar text to search query to filter result
        brandSearchController.searchBar.rx.text.subscribe(onNext: { [weak self] in
            self?.viewModel.searchPhone(query: $0 ?? "")
        }).disposed(by: bag)
        
        viewModel.fetchBrandsList()
    }
}
