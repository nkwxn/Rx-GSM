//
//  PhoneGalleryViewModel.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import RxSwift

class PhoneGalleryViewModel {
    var isLoadingHidden = BehaviorSubject<Bool>(value: false)
    var latestDevices = PublishSubject<[Phone]>()
    var brand: Brand?
    
    init(with brand: Brand? = nil) {
        self.brand = brand
    }
    
    func fetchPhoneData() {
        if let brand = brand {
            APIRequest.fetchPhones(with: brand) { [weak self] phoneData, errorMsg in
                self?.isLoadingHidden.onNext(true)
                self?.latestDevices.onNext(phoneData)
            }
        } else {
            APIRequest.fetchLatestPhones { [weak self] phoneData, errorMsg in
                self?.isLoadingHidden.onNext(true)
                self?.latestDevices.onNext(phoneData)
            }
        }
    }
}
