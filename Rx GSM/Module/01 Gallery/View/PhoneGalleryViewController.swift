//
//  PhoneGalleryViewController.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import UIKit
import RxSwift
import RxCocoa

class PhoneGalleryViewController: BaseViewController {
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: (view.frame.size.width / 2) - 30, height: 225)
        return layout
    }()
    
    lazy var phonesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(PhoneCollectionViewCell.self, forCellWithReuseIdentifier: PhoneCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.startAnimating()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        bindTableData()
    }
    
    var coordinator: PhoneGalleryCoordinator?
    var viewModel = PhoneGalleryViewModel()
    
    private func setupView() {
        self.title = "New Phones"
        view.addSubview(phonesCollectionView)
        view.addSubview(loadingIndicator)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        phonesCollectionView.frame = view.bounds
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func bindTableData() {
        viewModel.isLoadingHidden.bind(to: loadingIndicator.rx.isHidden).disposed(by: bag)
        
        viewModel.latestDevices.bind(
            to: phonesCollectionView.rx.items(
                cellIdentifier: PhoneCollectionViewCell.identifier,
                cellType: PhoneCollectionViewCell.self
            )
        ) { row, model, cell in
            cell.phoneNameLabel.text = model.phoneName
            cell.setImage(url: model.image)
        }.disposed(by: bag)
        
        phonesCollectionView.rx.modelSelected(Phone.self).bind { [weak self] model in
            let phoneName = model.phoneName
            self?.coordinator?.coordinateToPhoneSpec(phoneName: phoneName, slug: model.slug)
        }.disposed(by: bag)
        
        self.viewModel.fetchPhoneData()
    }
}
