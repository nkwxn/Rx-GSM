//
//  BasePhoneInfoView.swift
//  Rx GSM
//
//  Created by Nicholas on 04/04/22.
//

import UIKit
import RxSwift
import RxCocoa

class BasePhoneInfoView: BaseView {
    lazy var phoneImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var releaseDateView: InfoHeaderTextView = {
        let headerview = InfoHeaderTextView(frame: .zero)
        headerview.iconView.image = UIImage(systemName: "calendar")
        headerview.translatesAutoresizingMaskIntoConstraints = false
        return headerview
    }()
    
    lazy var dimensionView: InfoHeaderTextView = {
        let headerview = InfoHeaderTextView(frame: .zero)
        headerview.iconView.image = UIImage(systemName: "square.dashed")
        headerview.translatesAutoresizingMaskIntoConstraints = false
        return headerview
    }()
    
    lazy var operatingSystemView: InfoHeaderTextView = {
        let headerview = InfoHeaderTextView(frame: .zero)
        headerview.iconView.image = UIImage(systemName: "chevron.left.forwardslash.chevron.right")
        headerview.translatesAutoresizingMaskIntoConstraints = false
        return headerview
    }()
    
    lazy var storageView: InfoHeaderTextView = {
        let headerview = InfoHeaderTextView(frame: .zero)
        headerview.iconView.image = UIImage(systemName: "memorychip")
        headerview.translatesAutoresizingMaskIntoConstraints = false
        return headerview
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 14
        stackView.addArrangedSubview(releaseDateView)
        stackView.addArrangedSubview(dimensionView)
        stackView.addArrangedSubview(operatingSystemView)
        stackView.addArrangedSubview(storageView)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    weak var viewModel: PhoneSpecViewModel? {
        didSet {
            bindData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: ColorConst.gaGrey)
        setupView()
    }
    
    private func setupView() {
        addSubview(phoneImageView)
        
        phoneImageView.topAnchor
            .constraint(
                equalTo: topAnchor
            ).isActive = true
        phoneImageView.leftAnchor
            .constraint(
                equalTo: leftAnchor,
                constant: layoutMargins.left
            ).isActive = true
        phoneImageView.bottomAnchor
            .constraint(
                equalTo: bottomAnchor
            ).isActive = true
        phoneImageView.widthAnchor
            .constraint(
                equalToConstant: 170
            ).isActive = true
        
        addSubview(infoStackView)
        
        infoStackView.topAnchor
            .constraint(
                equalTo: topAnchor,
                constant: 14
            ).isActive = true
        infoStackView.rightAnchor
            .constraint(
                equalTo: rightAnchor,
                constant: -1 * layoutMargins.right
            ).isActive = true
        infoStackView.bottomAnchor
            .constraint(
                equalTo: bottomAnchor,
                constant: -14
            ).isActive = true
        infoStackView.leftAnchor
            .constraint(
                equalTo: phoneImageView.rightAnchor,
                constant: layoutMargins.left
            ).isActive = true
    }
    
    private func bindData() {
        viewModel?.phoneSpec.subscribe(onNext: { [weak self] phoneSpec in
            guard let phoneSpec = phoneSpec else { return }
            
            // Load image
            self?.viewModel?.loadImage(with: phoneSpec.thumbnail ?? "") { [weak self] data, apiError in
                if let data = data {
                    let image = UIImage(data: data)
                    self?.phoneImageView.image = image
                }
            }
            
            // Load text
            self?.releaseDateView.labelView.text = phoneSpec.releaseDate
            self?.dimensionView.labelView.text = phoneSpec.dimension
            self?.operatingSystemView.labelView.text = phoneSpec.os
            self?.storageView.labelView.text = phoneSpec.storage
        }).disposed(by: bag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
