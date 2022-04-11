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
        
        if UIDevice.current.orientation.isPortrait {
            layout.itemSize = CGSize(width: (view.frame.size.width / 2) - 30, height: 225)
        } else {
            layout.itemSize = CGSize(width: 165, height: 225)
        }
        return layout
    }()
    
    lazy var phonesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(PhoneCollectionViewCell.self, forCellWithReuseIdentifier: PhoneCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView()
        progressView.startAnimating()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        bindTableData()
    }
    
    var coordinator: PhoneGalleryCoordinator?
    var viewModel: PhoneGalleryViewModel!
    
    var phoneBrand: Brand? {
        didSet {
            self.title = phoneBrand?.brandName
        }
    }
    
    private func setupView() {
        view.addSubview(phonesCollectionView)
        view.addSubview(loadingIndicator)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if UIDevice.current.orientation.isLandscape {
            phonesCollectionView.frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            phonesCollectionView.frame = view.frame
        }
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
