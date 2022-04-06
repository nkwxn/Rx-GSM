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

        // Do any additional setup after loading the view.
        setupView()
        bindData()
    }
    
    func setupView() {
        view.addSubview(loadingView)
        loadingView.center = view.center
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        phoneSpecView.viewModel = self.viewModel
        view.addSubview(phoneSpecView)
        phoneSpecView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        phoneSpecView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        phoneSpecView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        phoneSpecView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func bindData() {
        viewModel.phoneSpec.asObserver().map({ spec -> String? in
            guard let spec = spec else { return "" }
            return Optional("\(spec.brand) \(spec.phoneName)")
        }).bind(to: self.rx.title).disposed(by: bag)
        
        viewModel.loadingHidden
            .bind(to: self.loadingView.rx.isHidden)
            .disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        
    }

}
