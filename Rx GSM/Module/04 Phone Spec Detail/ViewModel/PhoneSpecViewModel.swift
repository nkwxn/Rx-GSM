//
//  PhoneSpecViewModel.swift
//  Rx GSM
//
//  Created by Nicholas on 31/03/22.
//

import Foundation
import RxSwift

class PhoneSpecViewModel {
    var phoneSpec = PublishSubject<PhoneSpec?>()
    var loadingHidden = BehaviorSubject<Bool>(value: false)
    
    func fetchPhoneSpecData(phoneSlug: String) {
        APIRequest.fetchPhoneSpec(slug: phoneSlug) { [weak self] spec, error in
            self?.phoneSpec.onNext(spec)
            self?.loadingHidden.onNext(true)
        }
    }
    
    func loadImage(with url: String, completion: @escaping (Data?, String?) -> Void) {
        APIRequest.fetchImage(url: url, completion: completion)
    }
}
