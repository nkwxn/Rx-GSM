//
//  BaseViewController.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.systemBackground
    }
}
