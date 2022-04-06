//
//  PhoneCollectionViewCell.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import UIKit
import AlamofireImage

class PhoneCollectionCellViewModel {
    
}

class PhoneCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhoneCollectionViewCell"
    
    lazy var phoneImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(named: ColorConst.gaRed)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    lazy var phoneNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    private func initView() {
//        contentView.backgroundColor = .systemRed
        contentView.addSubview(phoneImage)
        contentView.addSubview(phoneNameLabel)
        contentView.backgroundColor = UIColor(named: ColorConst.gaGrey)
        contentView.layer.cornerRadius = 14
    }
    
    public func setImage(url: String) {
        APIRequest.fetchImage(url: url) { [weak self] data, error in
            self?.phoneImage.image = UIImage(data: data!)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        phoneNameLabel.frame = CGRect(
            x: 8,
            y: contentView.frame.size.height - 35,
            width: contentView.frame.size.width - 16,
            height: 35
        )
        phoneImage.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.frame.size.width,
            height: contentView.frame.size.height - 35
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
