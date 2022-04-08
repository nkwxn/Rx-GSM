//
//  PhoneSpecViewController.swift
//  Rx GSM
//
//  Created by Nicholas on 31/03/22.
//

import UIKit
import RxSwift
import RxCocoa

class PhoneSpecViewController: BaseViewController {
    lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.startAnimating()
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    lazy var phoneSpecView: BasePhoneInfoView = {
        let view = BasePhoneInfoView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coordinator: PhoneSpecCoordinator?
    var viewModel = PhoneSpecViewModel()
    
    deinit {
        print("This view is deinitialized. No memory leaks")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never
        setupView()
        bindData()
    }
    
    func setupView() {
        view.addSubview(loadingView)
        view.addSubview(phoneSpecView)
        phoneSpecView.viewModel = self.viewModel
    }
    
    func layoutViews() {
        loadingView.center = view.center
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Base constraint for phone info
        phoneSpecView
            .topAnchor
            .constraint(
                equalTo: view
                    .safeAreaLayoutGuide
                    .topAnchor,
                constant: 0
            ).isActive = true
        phoneSpecView
            .leadingAnchor
            .constraint(
                equalTo: view
                    .safeAreaLayoutGuide
                    .leadingAnchor,
                constant: 0
            ).isActive = true
        
        let phoneSpecPortraitHeight = phoneSpecView
            .heightAnchor
            .constraint(
                equalToConstant: 220
            )
        
        if UIDevice.current.orientation.isLandscape {
            print("Device rotated to landscape")
            phoneSpecPortraitHeight.isActive = false
            
            phoneSpecView
                .heightAnchor
                .constraint(
                    equalToConstant: view.safeAreaLayoutGuide.layoutFrame.size.height
                ).isActive = true
            
            phoneSpecView
                .widthAnchor
                .constraint(
                    equalToConstant: view.frame.size.height
                ).isActive = true
        } else {
            print("Device rotated to portrait")
            
            phoneSpecPortraitHeight.isActive = true
            
            phoneSpecView
                .widthAnchor
                .constraint(
                    equalToConstant: view.frame.size.width
                ).isActive = true
        }
    }
    
    func bindData() {
        viewModel.phoneSpec.map({ spec -> String? in
            guard let spec = spec else { return "" }
            return Optional("\(spec.brand) \(spec.phoneName)")
        }).bind(to: self.rx.title).disposed(by: bag)
        
        viewModel.loadingHidden
            .bind(to: self.loadingView.rx.isHidden)
            .disposed(by: bag)
        viewModel.loadingHidden
            .map {
                !$0
            }
            .bind(to: self.phoneSpecView.rx.isHidden)
            .disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
    }
}
