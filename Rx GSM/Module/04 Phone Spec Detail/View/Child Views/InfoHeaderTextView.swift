//
//  InfoHeaderTextView.swift
//  Rx GSM
//
//  Created by Nicholas on 05/04/22.
//

import UIKit

class InfoHeaderTextView: BaseView {
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var labelView: UILabel = {
        let label = UILabel()
        label.text = "ABCD"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupView()
    }
    
    func setupView() {
        addSubview(iconView)
        iconView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        iconView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor, multiplier: 1).isActive = true
        
        addSubview(labelView)
        labelView.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 10).isActive = true
        labelView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        labelView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
