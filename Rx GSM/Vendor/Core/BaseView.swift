//
//  BaseView.swift
//  Rx GSM
//
//  Created by Nicholas on 04/04/22.
//

import UIKit
import RxSwift

class BaseView: UIView {
    let bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
